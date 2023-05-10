# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            class Load
              runner_with :help do
                pos_arg :dump_path
              end

              def run
                nyi
              end
            end
          end
        end
      end
    end
  end
end
