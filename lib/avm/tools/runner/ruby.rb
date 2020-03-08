# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Ruby < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__

        DOC = <<~DOCOPT
          Ruby utilities for AVM.

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
