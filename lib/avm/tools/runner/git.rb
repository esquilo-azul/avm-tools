# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
Dir["#{File.dirname(__FILE__)}/#{::File.basename(__FILE__, '.*')}/*.rb"].each do |path|
  require path
end

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
        DOCOPT
      end
    end
  end
end
