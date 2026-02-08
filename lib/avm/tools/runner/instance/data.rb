# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          runner_with :help, :subcommands do
            desc 'Data utilities for EacRailsBase0 instances.'
            subcommands
          end

          for_context :data_owner

          # @return [Avm::Instances::Data::Package]
          def data_owner
            instance.data_package
          end
        end
      end
    end
  end
end
