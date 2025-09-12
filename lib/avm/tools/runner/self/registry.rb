# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Self
        class Registry
          runner_with :help do
            desc 'Show information from registry'
          end

          def run
            ::Avm::Registry.registries.each do |registry|
              infov registry.module_suffix, registry.registered_modules.count
              registry.registered_modules.each { |m| infov '  * ', m }
            end
          end
        end
      end
    end
  end
end
