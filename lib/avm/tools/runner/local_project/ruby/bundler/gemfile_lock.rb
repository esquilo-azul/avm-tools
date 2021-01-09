# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class LocalProject
        class Ruby < ::EacRubyUtils::Console::DocoptRunner
          class Bundler < ::EacRubyUtils::Console::DocoptRunner
            class GemfileLock < ::EacRubyUtils::Console::DocoptRunner
              include ::EacCli::DefaultRunner

              runner_definition do
                desc 'Manipulage a "Gemfile.lock" file.'
                bool_opt '-c', '--continue', 'Continue Git rebase/cherry-pick.'
                bool_opt '-i', '--install', 'Run "bundle install".'
                bool_opt '-u', '--update', 'Run "bundle update".'
                bool_opt '-r', '--recursive', 'Run until Git rebase/cherry-pick is finished.'
                bool_opt '-a', '--all', 'Same as "-ciru".'
              end

              def run
                loop do
                  git_reset_checkout
                  bundle_update
                  bundle_install
                  git_continue
                  break if complete?
                end
              end

              private

              def complete?
                !option_or_all?('--recursive') || !conflict?
              end

              def rebasing?
                instance.git_repo.root_path.join('.git', 'rebase-merge').exist?
              end

              def git_reset_checkout
                return unless check_capability(__method__, :git_repo, nil)

                infom 'Reseting...'
                instance.git_repo.command('reset', gemfile_lock).system!
                infom 'Checkouting...'
                instance.git_repo.command('checkout', '--', gemfile_lock).system!
              end

              def bundle_install
                return unless check_capability(__method__, :ruby_gem, '--install')

                infom '"bundle install"...'
                bundle_run('install')
              end

              def bundle_update
                return unless check_capability(__method__, :ruby_gem, '--update')

                infom '"bundle update"...'
                bundle_run('update')
              end

              def git_continue
                return unless check_capability(__method__, :git_repo, '--continue')

                infom "Adding \"#{gemfile_lock}\"..."
                instance.git_repo.command('add', gemfile_lock).execute!
                if rebase_conflict?
                  git_continue_run('rebase')
                elsif cherry_conflict?
                  git_continue_run('cherry-pick')
                else
                  raise 'Unknown how to continue'
                end
              end

              def git_continue_run(command)
                infom "\"#{command}\" --continue..."
                cmd = instance.git_repo.command(command, '--continue').envvar('GIT_EDITOR', 'true')
                return unless !cmd.system && !conflict?

                fatal_error "\"#{cmd}\" failed and there is no conflict"
              end

              def gemfile_lock
                'Gemfile.lock'
              end

              def git_uncached
                ::EacGit::Local.new(git_path)
              end

              def bundle_run(*args)
                instance.ruby_gem.bundle(*args).system!
              end

              def git_path
                '.'
              end

              def conflict?
                rebase_conflict? || cherry_conflict?
              end

              def rebase_conflict?
                instance.git_repo.root_path.join('.git', 'REBASE_HEAD').exist?
              end

              def cherry_conflict?
                instance.git_repo.root_path.join('.git', 'CHERRY_PICK_HEAD').exist?
              end

              def option_or_all?(option)
                options.fetch(option) || options.fetch('--all')
              end

              def instance
                context(:instance)
              end

              def check_capability(caller, capability, option)
                return false unless option.blank? || option_or_all?(option)
                return true if instance.respond_to?(capability)

                warn "Cannot run #{caller}: instance has no capability \"#{capability}\""
                false
              end
            end
          end
        end
      end
    end
  end
end
