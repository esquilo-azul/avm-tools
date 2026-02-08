# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Issue
          runner_with :help, :subcommands do
            desc 'Issue operations within source.'
            subcommands
          end
        end
      end
    end
  end
end
