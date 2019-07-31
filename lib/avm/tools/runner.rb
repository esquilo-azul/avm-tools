# frozen_string_literal: true

require 'avm/tools/git/complete_issue'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      DOC = <<~DOCOPT
        Tools for AVM.

        Usage:
          __PROGRAM__ [options] git complete-issue
          __PROGRAM__ -h | --help

        Options:
          -h --help             Show this screen.
      DOCOPT

      private

      def run
        raise "Unknown command: #{options}" unless git_complete_issue?

        ::Avm::Tools::Git::CompleteIssue.new(git_complete_issue_options)
      end

      def git_complete_issue_options
        { dir: '.' }
      end

      def git_complete_issue?
        options.fetch('git') && options.fetch('complete-issue')
      end
    end
  end
end
