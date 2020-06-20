# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_git/local'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Subrepo < ::EacRubyUtils::Console::DocoptRunner
          class Check < ::EacRubyUtils::Console::DocoptRunner
            include ::EacCli::DefaultRunner

            runner_definition do
              desc 'Check status of subrepos.'
              bool_opt '-a', '--all', 'Select all subrepos.'
              bool_opt '-f', '--fix-parent', 'Fix parent SHA1.'
              bool_opt '-r', '--remote', 'Check subrepos remote.'
              pos_arg :subrepos, repeat: true, optional: true
            end

            def run
              subrepo_checks.show_result
              fatal_error 'Failed' if subrepo_checks.result.error?
            end

            private

            def subrepo_checks_uncached
              r = ::Avm::Git::SubrepoChecks.new(local_repos)
              r.check_remote = options.fetch('--remote')
              r.fix_parent = options.fetch('--fix-parent')
              r.add_all_subrepos if options.fetch('--all')
              r.add_subrepos(*options.fetch('<subrepos>'))
              r
            end

            def local_repos_uncached
              ::EacGit::Local.new(context(:git))
            end
          end
        end
      end
    end
  end
end
