# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Issue
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Issue operations within source.'
            subcommands
          end
        end
      end
    end
  end
end
