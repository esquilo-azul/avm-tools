# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Data utilities for EacRailsBase0 instances.'
            subcommands
          end

          # @return [Avm::Instances::Data::Package]
          def data_owner
            instance.data_package
          end
        end
      end
    end
  end
end
