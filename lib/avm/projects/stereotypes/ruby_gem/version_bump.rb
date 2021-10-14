# frozen_string_literal: true

require 'avm/patches/i18n'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      class RubyGem
        class VersionBump
          enable_speaker
          common_constructor :instance, :target_version

          def run
            git_checkout
            change_version
            bundle_run
            git_commit
          end

          private

          def bundle_run
            infom 'Running "bundle install"...'
            instance.ruby_gem.bundle('install').execute!
          end

          def change_version
            infom 'Setting project version...'
            instance.version = target_version
          end

          def git_checkout
            return unless instance.respond_to?(:git_repo)

            infom "Checkouting #{changing_files.map(&:to_path).join(', ')}..."
            instance.git_repo.command('checkout', '--',
                                      *changing_files.map(&:to_path)).execute!
          end

          def git_commit
            return unless instance.respond_to?(:git_repo)

            infom "Commiting #{changing_files.map(&:to_path).join(', ')}..."
            instance.git_repo.command('commit', '-m', git_commit_message, '--',
                                      *changing_files.map(&:to_path)).execute!
          end

          def git_commit_message
            i18n_translate(__method__, version: target_version, __locale: instance.locale)
          end

          def changing_files
            [instance.ruby_gem.gemfile_lock_path, instance.ruby_gem.version_file_path]
          end
        end
      end
    end
  end
end
