# frozen_string_literal: true

require 'avm/self'
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
    end
  end
end
