# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/files/rotate'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Files < ::EacRubyUtils::Console::DocoptRunner
        class Rotate < ::EacRubyUtils::Console::DocoptRunner
          DOC = <<~DOCOPT
            Rotates a file (Like a backup).

            Usage:
              __PROGRAM__ <path>
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
          DOCOPT

          def run
            ::Avm::Files::Rotate.new(options.fetch('<path>')).run
          end
        end
      end
    end
  end
end
