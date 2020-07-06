# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)
require 'avm/self'
require 'avm/tools/version'
require 'eac_ruby_base0/runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
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
