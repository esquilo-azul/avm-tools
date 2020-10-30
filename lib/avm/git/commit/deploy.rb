# frozen_string_literal: true

require 'addressable'
require 'eac_ruby_utils/core_ext'
require 'avm/files/appendable'
require 'avm/patches/object/template'

module Avm
  module Git
    class Commit
      class Deploy
        include ::Avm::Files::Appendable
        enable_simple_cache

        attr_reader :build_dir, :commit, :target_env, :target_path

        def initialize(commit, target_env, target_path)
          @commit = commit
          @target_env = target_env
          @target_path = target_path
        end

        def run
          on_build_dir do
            copy_git_content
            write_appended_on(build_dir)
            mkdir_target
            clear_content
            send_untar_package
            set_target_permission
          end
        end

        private

        def on_build_dir
          @build_dir = ::Dir.mktmpdir
          yield
        ensure
          ::FileUtils.rm_rf(@build_dir)
        end

        def copy_git_content
          git_archive_command.pipe(untar_git_archive_command).execute!
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
