# frozen_string_literal: true

require 'avm/self'
require 'avm/tools/version'
require 'eac_ruby_base0/runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      include ::EacRubyBase0::Runner
      require_sub __FILE__

      runner_definition do
        desc 'Tools for AVM.'
      end

      def application
        ::Avm::Self.application
      end
    end
  end
end
