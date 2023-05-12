# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            class Dump
              runner_with :help do
                pos_arg :dump_path, optional: true
              end

              def run
                runner_context.call(:data_unit).dump(dump_path)
              end

              # @return [String]
              def help_extra_text
                "Default dump path: \"#{default_dump_path}\""
              end

              # @return [Pathname]
              def dump_path
                (parsed.dump_path || default_dump_path).to_pathname
              end

              # @return [String]
              def default_dump_path
                runner_context.call(:data_unit).data_default_dump_path
              end
            end
          end
        end
      end
    end
  end
end
