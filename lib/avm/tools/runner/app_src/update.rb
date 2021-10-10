# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Update
          runner_with :help do
            desc 'Update local project.'
          end

          def run
            infov 'Path', runner_context.call(:subject).path
            runner_context.call(:subject).update
          end
        end
      end
    end
  end
end
