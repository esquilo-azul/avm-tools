# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)
require 'avm/tools/version'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      include ::EacRubyUtils::Console::Speaker

      DOC = <<~DOCOPT
        Tools for AVM.

        Usage:
          __PROGRAM__ [options] __SUBCOMMANDS__
          __PROGRAM__ --version
          __PROGRAM__ -h | --help

        Options:
          -h --help             Show this screen.
          -V --version          Show version.
          -q --quiet            Quiet mode.
      DOCOPT

      def run
        on_speaker_node do |node|
          node.stderr = ::StringIO.new if options.fetch('--quiet')
          if options.fetch('--version')
            out(::Avm::Tools::VERSION + "\n")
          else
            run_with_subcommand
          end
        end
      end
    end
  end
end
