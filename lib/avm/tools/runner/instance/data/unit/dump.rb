# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            class Dump
              runner_with :help, :instance_data_dump
            end
          end
        end
      end
    end
  end
end
