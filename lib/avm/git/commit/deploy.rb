# frozen_string_literal: true

require 'addressable'
require 'eac_ruby_utils/simple_cache'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

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
          when 'ssh' then ::EacRubyUtils::Envs.ssh(uri.authority)
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

        attr_reader :commit, :target_env, :target_path

        def initialize(commit, target_env, target_path)
          @commit = commit
          @target_env = target_env
          @target_path = target_path
          run
        end

        private

        def run
          mkdir_target
          clear_content
          send_untar_package
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
          git_archive_command.pipe(untar_command).execute!
        end

        def git_archive_command
          commit.git.command('archive', '--format=tar', commit.sha1)
        end

        def untar_command
          target_env.command('tar', '-xf', '-', '-C', target_path)
        end
      end
    end
  end
end
