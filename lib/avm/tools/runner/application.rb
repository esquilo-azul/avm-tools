# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Application
        runner_with :help, :subcommands do
          pos_arg :application_id
          subcommands
        end
        for_context :application

        private

        def application_uncached
          ::Avm::Registry.applications.detect(parsed.application_id)
        end

        require_sub __FILE__
      end
    end
  end
end
