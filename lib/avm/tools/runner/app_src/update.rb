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
            infov 'Path', runner_context.call(:instance).path
            runner_context.call(:instance).run_job(:update)
          end
        end
      end
    end
  end
end
