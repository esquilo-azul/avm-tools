# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            class Load
              runner_with :help, :instance_data_load

              # @return [Avm::Instances::Data::Unit]
              def source_instance_data_owner
                source_instance.data_package.unit(data_owner.identifier)
              end
            end
          end
        end
      end
    end
  end
end
