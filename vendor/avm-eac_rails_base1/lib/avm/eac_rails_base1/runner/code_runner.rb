# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/bundle'
require 'eac_cli/core_ext'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class CodeRunner
        runner_with :help, ::Avm::EacRailsBase1::RunnerWith::Bundle do
          desc 'Runs a Ruby code with "rails runner".'
          pos_arg :code
        end

        def run
          infov 'Environment', runner_context.call(:instance).host_env
          bundle_run
        end

        def bundle_args
          %w[exec rails runner] + [parsed.code]
        end
      end
    end
  end
end
