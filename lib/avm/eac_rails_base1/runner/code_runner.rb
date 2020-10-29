# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class CodeRunner < ::EacRubyUtils::Console::DocoptRunner
        enable_console_speaker
        enable_simple_cache

        DOC = <<~DOC
          Runs a Ruby code with "rails runner".

          Usage:
            __PROGRAM__ [options] <code>
            __PROGRAM__ -h | --help

          Options:
            -h --help         Show this screen.
            -e --environment  Specifies the environment for the runner to
                              operate (test/development/production). Default: "development".
        DOC

        def run
          infov 'Runner arguments', runner_args
          infov 'Environment', context(:instance).host_env
          runner_command.system!
        end

        def runner_command_uncached
          context(:instance).bundle(*bundle_args)
        end

        def bundle_args
          %w[exec rails runner] + runner_args
        end

        def runner_args
          options.fetch('--environment').if_present([]) { |v| ['--environment', v] } +
            [options.fetch('<code>')]
        end
      end
    end
  end
end
