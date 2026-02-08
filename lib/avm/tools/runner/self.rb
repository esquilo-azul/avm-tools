# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Self
        runner_with :help, :subcommands do
          desc 'Utilities for self avm-tools.'
          subcommands
        end

        def instance
          ::Avm::Self::Instance.default
        end
      end
    end
  end
end
