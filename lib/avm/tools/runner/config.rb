# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Config
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Configuration utilities.'
          subcommands
        end
      end
    end
  end
end
