# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class ApplicationStereotypes
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
            ::Avm::Registry.application_stereotypes.available
              .sort_by { |s| [s.name, s.namespace_module] }
          end
        end
      end
    end
  end
end
