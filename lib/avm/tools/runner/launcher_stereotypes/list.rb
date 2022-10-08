# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class LauncherStereotypes
        class List
          runner_with :help, :output

          def run
            infov 'Found', stereotypes.count
            run_output
          end

          def output_content
            stereotypes.map { |s| "#{s}\n" }.join
          end

          private

          def stereotypes
            registry_stereotypes
          end

          def registry_stereotypes
            ::Avm::Registry.launcher_stereotypes.available.sort_by { |s| [s.name] }
          end
        end
      end
    end
  end
end
