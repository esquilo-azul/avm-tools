# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/self/instance'

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
          ::Avm::Self::Instance.default
        end
      end
    end
  end
end
