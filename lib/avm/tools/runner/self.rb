# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'
require 'avm/self'

module Avm
  module Tools
    class Runner
      class Self < ::EacRubyUtils::Console::DocoptRunner
        ::EacRubyUtils.require_sub(__FILE__)

        DOC = <<~DOCOPT
          Utilities for self avm-tools.

          Usage:
            __PROGRAM__ [options] __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
        DOCOPT

        def instance
          ::Avm::Self.instance
        end
      end
    end
  end
end
