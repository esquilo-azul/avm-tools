# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class LauncherStereotypes
        require_sub __FILE__
        runner_with :help, :subcommands do
          subcommands
        end
      end
    end
  end
end
