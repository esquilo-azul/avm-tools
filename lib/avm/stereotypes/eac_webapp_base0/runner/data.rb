# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'

module Avm
  module Stereotypes
    module EacWebappBase0
      module Runner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          ::EacRubyUtils.require_sub(__FILE__)

          DOC = <<~DOCOPT
            Data utilities for EacRailsBase0 instances.

            Usage:
              __PROGRAM__ __SUBCOMMANDS__
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
          DOCOPT
        end
      end
    end
  end
end
