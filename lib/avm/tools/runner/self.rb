# frozen_string_literal: true

require 'avm/core_ext'
require 'avm/self'

module Avm
  module Tools
    class Runner
      class Self
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Utilities for self avm-tools.'
          subcommands
        end

        def instance
          ::Avm::Self.instance
        end
      end
    end
  end
end
