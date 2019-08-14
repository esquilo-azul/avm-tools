# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/tools/git/complete_issue'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class CompleteIssue < ::EacRubyUtils::Console::DocoptRunner
          DOC = <<~DOCOPT
            Closes a issue in a Git repository.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
              -C <path>             Path to Git repository [default: .].
          DOCOPT

          def run
            ::Avm::Tools::Git::CompleteIssue.new(git_complete_issue_options)
          end

          private

          def git_complete_issue_options
            { dir: options.fetch('-C') }
          end
        end
      end
    end
  end
end
