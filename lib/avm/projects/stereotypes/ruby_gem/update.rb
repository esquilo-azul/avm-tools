# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/patches/class/i18n'

module Avm
  module Projects
    module Stereotypes
      class RubyGem
        class Update
          TRANSLATE_CLASS = self

          enable_console_speaker
          common_constructor :instance

          def run
            gemfile_lock_checkout
            bundle_update
            gemfile_lock_commit
          end

          private

          def bundle_update
            infom 'Running "bundle update"...'
            instance.ruby_gem.bundle('update').execute!
            infom 'Running "bundle install"...'
            instance.ruby_gem.bundle('install').execute!
          end

          def gemfile_lock_checkout
            return unless instance.respond_to?(:git_repo)

            infom 'Checkouting Gemfile.lock...'
            instance.git_repo.command('checkout', '--',
                                      instance.ruby_gem.gemfile_lock_path.to_path).execute!
          end

          def gemfile_lock_commit
            return unless instance.respond_to?(:git_repo)

            if gemfile_lock_changed?
              infom 'Commiting Gemfile.lock...'
              instance.git_repo.command('commit', '-m', gemfile_lock_commit_message, '--',
                                        instance.ruby_gem.gemfile_lock_path).execute!
            else
              infom 'Gemfile.lock did not change'
            end
          end

          def gemfile_lock_commit_message
            TRANSLATE_CLASS.translate(__method__, __locale: instance.locale)
          end

          def gemfile_lock_changed?
            instance.git_repo.dirty_file?(instance.ruby_gem.gemfile_lock_path)
          end
        end
      end
    end
  end
end
