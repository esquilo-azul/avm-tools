# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
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
