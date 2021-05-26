# frozen_string_literal: true

require 'avm/launcher/git/base'
require 'avm/git/commit'

module Avm
  module Projects
    module Stereotypes
      class Git
        class Update
          class Subrepo
            TRANSLATE_CLASS = self

            require_sub __FILE__, include_modules: true
            enable_simple_cache
            enable_speaker
            common_constructor :parent_update, :subpath do
              self.subpath = subpath.to_pathname
            end

            delegate :git_repo, :instance, to: :parent_update

            def run
              run_banner
              if base_commit.sha1 == pull_commit.sha1
                infom 'No new commit (No changes)'
              elsif fix_message.present?
                on_fix_message_present
              else
                warn 'No fix message found'
              end
            end

            private

            def base_commit_uncached
              ::Avm::Git::Commit.new(git_repo, git_repo.rev_parse('HEAD'))
            end

            def on_fix_message_present
              infom 'Fixing message...'
              infov 'Message', fix_message
              git_repo.command('commit', '--amend', '-m', fix_message).execute!
            end

            def pull_commit_uncached
              base_commit
              infom 'Pulling subrepo...'
              git_repo.command('subrepo', 'pull', '--force', subpath).execute!
              ::Avm::Git::Commit.new(
                ::Avm::Launcher::Git::Base.new(git_repo.root_path.to_path),
                git_repo.rev_parse('HEAD')
              )
            end

            def run_banner
              infov 'Base SHA1', base_commit.sha1
              infov 'Pull SHA1', pull_commit.sha1
            end

            def fix_message
              TRANSLATE_CLASS.translate(
                fix_message_translate_key, subpath: subpath, name: subpath.basename,
                                           __locale: instance.locale
              )
            end

            def fix_message_translate_key
              if gitrepo_only_changed?
                :gitrepo_only_changed_fix_message
              else
                :content_updated_fix_message
              end
            end

            def gitrepo_only_changed?
              pull_commit.files.count == 1 &&
                ::File.basename(pull_commit.files.first.path) == '.gitrepo'
            end
          end
        end
      end
    end
  end
end
