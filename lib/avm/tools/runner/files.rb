# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/tools/runner/files/rotate'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Files < ::EacRubyUtils::Console::DocoptRunner
        DOC = <<~DOCOPT
          Files utilities for AVM.

          Usage:
            __PROGRAM__ [options] __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
        DOCOPT
      end
    end
  end
end
