# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class LauncherStereotypes
        class List
          runner_with :help, :output do
            bool_opt '-d', '--deprecated'
          end

          def run
            infov 'Found', stereotypes.count
            run_output
          end

          def output_content
            stereotypes.map { |s| "#{s}\n" }.join
          end

          private

          def stereotypes
            (parsed.deprecated? ? deprecated_stereotypes : registry_stereotypes)
          end

          def registry_stereotypes
            ::Avm::Registry.launcher_stereotypes.available.sort_by { |s| [s.name] }
          end

          def deprecated_stereotypes
            ::Avm::Launcher::Stereotype.stereotypes.sort_by { |s| [s.stereotype_name] }
          end
        end
      end
    end
  end
end
