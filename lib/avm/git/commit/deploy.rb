# frozen_string_literal: true

require 'addressable'
require 'eac_ruby_utils/simple_cache'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)
require 'avm/patches/object/template'

module Avm
  module Git
    class Commit
      class << self
        def target_url_to_env_path(target_url)
          uri = ::Addressable::URI.parse(target_url)
          uri.scheme = 'file' if uri.scheme.blank?
          [uri_to_env(uri), uri.path]
        end

        private

        def uri_to_env(uri)
          case uri.scheme
          when 'file' then ::EacRubyUtils::Envs.local
          when 'ssh' then ::EacRubyUtils::Envs.ssh(uri)
          else "Invalid schema \"#{uri.schema}\" (URI: #{uri})"
          end
        end
      end

      def deploy_to_env_path(target_env, target_path)
        Deploy.new(self, target_env, target_path)
      end

      def deploy_to_url(target_url)
        Deploy.new(self, *self.class.target_url_to_env_path(target_url))
      end

      class Deploy
        include ::EacRubyUtils::SimpleCache

        attr_reader :commit, :target_env, :target_path, :appended_directories, :variables_source

        def initialize(commit, target_env, target_path)
          @commit = commit
          @target_env = target_env
          @target_path = target_path
          @appended_directories = []
          @variables_source = nil
        end

        def append_directory(directory)
          @appended_directories << directory
          self
        end

        def append_directories(directories)
          directories.each { |directory| append_directory(directory) }
          self
        end

        def variables_source_set(source)
          @variables_source = source
          self
        end

        def run
          on_build_dir do
            copy_git_content
            appended_directories.each { |directory| copy_appended_directory(directory) }
            mkdir_target
            clear_content
            send_untar_package
            set_target_permission
          end
        end

        private

        attr_reader :build_dir

        def on_build_dir
          @build_dir = ::Dir.mktmpdir
          yield
        ensure
          ::FileUtils.rm_rf(@build_dir)
        end

        def copy_git_content
          git_archive_command.pipe(untar_git_archive_command).execute!
        end

        def copy_appended_directory(directory)
          raise 'Variables source not set' if variables_source.blank?

          ::EacRubyUtils::Templates::Directory.new(directory).apply(variables_source, build_dir)
        end

        def mkdir_target
          target_env.command('mkdir', '-p', target_path).execute!
        end

        def clear_content
          target_env.command(
            'find', target_path, '-mindepth', '1', '-maxdepth', '1', '-exec', 'rm', '-rf', '{}', ';'
          ).execute!
        end

        def send_untar_package
          tar_build_command.pipe(untar_build_command).execute!
        end

        def set_target_permission
          target_env.command('chmod', '755', target_path).execute!
        end

        def git_archive_command
          commit.git.command('archive', '--format=tar', commit.sha1)
        end

        def untar_git_archive_command
          source_env.command('tar', '-xf', '-', '-C', build_dir)
        end

        def tar_build_command
          source_env.command('tar', '-czO', '-C', build_dir, '.')
        end

        def untar_build_command
          target_env.command('tar', '-xzf', '-', '-C', target_path)
        end

        def source_env
          ::EacRubyUtils::Envs.local
        end
      end
    end
  end
end
