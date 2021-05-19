# frozen_string_literal: true

require 'avm/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Info
          runner_with :help do
            desc 'Show information about local project instance.'
          end

          def run
            infov 'Path', runner_context.call(:instance).path
            infov 'Stereotypes', runner_context.call(:instance).stereotypes.map(&:label).join(', ')
          end
        end
      end
    end
  end
end
