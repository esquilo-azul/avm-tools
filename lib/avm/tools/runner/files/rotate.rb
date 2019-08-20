# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/files/rotate'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Files < ::EacRubyUtils::Console::DocoptRunner
        class Rotate < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Rotates a file (Like a backup).

            Usage:
              __PROGRAM__ <path>
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
          DOCOPT

          def run
            error_message = ::Avm::Files::Rotate.new(options.fetch('<path>')).run
            fatal_error(error_message) if error_message
          end
        end
      end
    end
  end
end
