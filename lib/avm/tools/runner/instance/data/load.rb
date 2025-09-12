# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Load
            runner_with :help, :include_exclude, :instance_data_load do
              desc 'Load utility for instance.'
            end

            # @return [Avm::Instances::Data::Package]
            def source_instance_data_owner
              source_instance.data_package
            end
          end
        end
      end
    end
  end
end
