# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Clear
            runner_with :help, :include_exclude, :instance_data_clear
          end
        end
      end
    end
  end
end
