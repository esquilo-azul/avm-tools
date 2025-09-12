# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Files
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Files utilities for AVM.'
          subcommands
        end
      end
    end
  end
end
