# frozen_string_literal: true

require 'avm/self'
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

      def application
        ::Avm::Self.application
      end

      def extra_available_subcommands
        ::Avm::Registry.runners.registered_modules.map { |k| [k.command_argument, k] }.to_h
      end
    end
  end
end
