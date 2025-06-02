# frozen_string_literal: true

require 'avm/tools/self'
require 'avm/registry'
require 'avm/tools/version'
require 'eac_ruby_base0/runner'

module Avm
  module Tools
    class Runner
      require_sub __FILE__
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
