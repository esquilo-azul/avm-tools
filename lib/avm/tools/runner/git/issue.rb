# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Issue < ::EacRubyUtils::Console::DocoptRunner
          DOC = <<~DOCOPT
            Issue utilities for AVM/Git.

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
end
