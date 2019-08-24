# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Issue < ::EacRubyUtils::Console::DocoptRunner
          class Complete < ::EacRubyUtils::Console::DocoptRunner
            DOC = <<~DOCOPT
              Closes a issue in a Git repository.

              Usage:
                __PROGRAM__ [options]
                __PROGRAM__ -h | --help

              Options:
                -h --help             Show this screen.
                -C <path>             Path to Git repository [default: .].
                --no-avm              Does not require valid AVM issue\'s branch/tag name.
            DOCOPT

            def run
              complete = ::Avm::Git::Issue::Complete.new(git_complete_issue_options)
              complete.start_banner
              fatal_error('Some validation did not pass') unless complete.run
            end

            private

            def git_complete_issue_options
              { dir: options.fetch('-C'), no_avm_branch_name: options.fetch('--no-avm') }
            end
          end
        end
      end
    end
  end
end
