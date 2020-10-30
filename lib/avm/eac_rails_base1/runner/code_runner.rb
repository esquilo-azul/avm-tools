# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/bundle'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class CodeRunner < ::EacRubyUtils::Console::DocoptRunner
        runner_with ::Avm::EacRailsBase1::RunnerWith::Bundle
        runner_definition do
          desc 'Runs a Ruby code with "rails runner".'
          pos_arg :code
        end

        def run
          infov 'Environment', context(:instance).host_env
          bundle_run
        end

        def bundle_args
          %w[exec rails runner] + [options.fetch('<code>')]
        end
      end
    end
  end
end