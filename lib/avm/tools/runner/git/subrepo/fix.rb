# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/git/auto_commit/rules/unique'
require 'avm/git/file_auto_fixup'
require 'avm/git/subrepo_checks'
require 'eac_git/local'

module Avm
  module Tools
    class Runner
      class Git
        class Subrepo
          class Fix
            runner_with :help do
              desc 'Fix git-subrepos\' parent property.'
            end

            def run
              loop do
                break if fix

                amend_each
                rebase_fixup
              end
            end

            private

            def amend_each
              infov 'Dirty files', local_repos.dirty_files.count
              local_repos.dirty_files.each do |file|
                infov '  * Ammending', file.path
                ::Avm::Git::FileAutoFixup.new(runner_context.call(:git), file.path,
                                              [::Avm::Git::AutoCommit::Rules::Unique.new]).run
              end
            end

            def fix
              infom 'Checking/fixing...'
              c = new_check(true)
              c.show_result
              !c.result.error?
            end

            def new_check(fix_parent = false)
              r = ::Avm::Git::SubrepoChecks.new(local_repos).add_all_subrepos
              r.fix_parent = fix_parent
              r
            end

            def local_repos_uncached
              ::EacGit::Local.new(runner_context.call(:git))
            end

            def rebase_fixup
              local_repos.command('rebase', '-i', 'origin/master', '--autosquash').envvar(
                'GIT_SEQUENCE_EDITOR', 'true'
              ).or(
                local_repos.command('rebase', '--continue').envvar('GIT_SEQUENCE_EDITOR', 'true')
              ).system!
            end
          end
        end
      end
    end
  end
end
