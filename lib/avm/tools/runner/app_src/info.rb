# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Info
          runner_with :help do
            desc 'Show information about local project instance.'
          end

          def run
            infov 'Path', instance.path
            infov 'Stereotypes', instance.stereotypes.map(&:label).join(', ')
            show_subs
          end

          private

          def show_subs
            infov 'Sub applications', instance.avm_instance.subs.count
            instance.avm_instance.subs.each do |subapp|
              infov '  * ', subapp.relative_path
            end
          end

          def instance
            runner_context.call(:instance)
          end
        end
      end
    end
  end
end
