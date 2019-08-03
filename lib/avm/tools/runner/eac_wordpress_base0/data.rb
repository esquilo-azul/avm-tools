# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/tools/runner/eac_wordpress_base0/data/dump'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          DOC = <<~DOCOPT
            Data utilities for EacWordpressBase0 instances.

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
