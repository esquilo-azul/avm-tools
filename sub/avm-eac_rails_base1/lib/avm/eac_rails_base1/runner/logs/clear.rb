# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/rails_environment'
require 'avm/eac_webapp_base0/runner'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Logs
        class Clear
          runner_with :help, ::Avm::EacRailsBase1::RunnerWith::Bundle do
            desc 'Clear logs.'
          end

          def run
            bundle_run
          end

          def bundle_args
            %w[exec rake log:clear]
          end
        end
      end
    end
  end
end
