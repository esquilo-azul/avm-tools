# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      include ::EacRubyBase0::Runner

      runner_definition do
        desc 'Tools for AVM.'
      end

      delegate :application, to: :'::Avm::Tools::Self'

      def extra_available_subcommands
        ::Avm::Registry.runners.registered_modules.index_by(&:command_argument)
      end
    end
  end
end
