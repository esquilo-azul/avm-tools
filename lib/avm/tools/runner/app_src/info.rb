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
          end

          private

          def instance
            runner_context.call(:instance)
          end
        end
      end
    end
  end
end
