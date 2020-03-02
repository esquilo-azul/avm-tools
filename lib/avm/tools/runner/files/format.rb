# frozen_string_literal: true

require 'avm/files/formatter'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Files < ::EacRubyUtils::Console::DocoptRunner
        class Format < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Format files.

            Usage:
              __PROGRAM__ [options] [<paths>...]
              __PROGRAM__ -h | --help

            Options:
              -h --help                 Show this screen.
              -a --apply                Confirm changes.
              -n --no-recursive         No recursive.
              -v --verbose              Verbose
          DOCOPT

          def run
            ::Avm::Files::Formatter.new(source_paths, formatter_options).run
          end

          def formatter_options
            { apply: options.fetch('--apply'), recursive: !options.fetch('--no-recursive'),
              verbose: options.fetch('--verbose') }
          end

          def source_paths
            options.fetch('<paths>').if_present(%w[.])
          end
        end
      end
    end
  end
end
