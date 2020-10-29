# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class CodeRunner < ::EacRubyUtils::Console::DocoptRunner
        runner_with
        runner_definition do
          desc 'Runs a Ruby code with "rails runner".'
          arg_opt '-e', '--environment', 'Specifies the environment for the runner to operate' \
            ' (test/development/production). Default: "development".'
          pos_arg :code
        end

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
