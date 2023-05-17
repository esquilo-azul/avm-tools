# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            class Clear
              runner_with :help, :instance_data_clear
            end
          end
        end
      end
    end
  end
end
