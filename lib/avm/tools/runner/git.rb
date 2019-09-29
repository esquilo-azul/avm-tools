# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        DOC = <<~DOCOPT
          Git utilities for AVM.

          Usage:
            __PROGRAM__ [options] __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
            -C <path>                 Path to Git repository [default: .].
        DOCOPT

        def repository_path
          options.fetch('-C')
        end
      end
    end
  end
end
