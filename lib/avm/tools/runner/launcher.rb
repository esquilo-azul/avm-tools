# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Launcher
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Utilities to deploy applications and libraries.'
          subcommands
        end
      end
    end
  end
end
