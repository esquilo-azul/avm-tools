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
              __PROGRAM__ [options] <path>
              __PROGRAM__ -h | --help

            Options:
              -h --help                 Show this screen.
              -L --space-limit=<space>  Limit by <space> the space used by rotated files.
          DOCOPT

          def run
            error_message = rotate.run
            fatal_error(error_message) if error_message
          end

          def rotate
            @rotate ||= ::Avm::Files::Rotate.new(
              options.fetch('<path>'),
              space_limit: options.fetch('--space-limit')
            )
          end
        end
      end
    end
  end
end
