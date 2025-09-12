# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Applications
        class List
          runner_with :help, :output

          def run
            infov 'Found', applications.count
            run_output
          end

          def output_content
            applications.map { |s| "#{s}\n" }.join
          end

          private

          def applications_uncached
            ::Avm::Registry.applications.available
              .sort_by { |s| [s.id] }
          end
        end
      end
    end
  end
end
