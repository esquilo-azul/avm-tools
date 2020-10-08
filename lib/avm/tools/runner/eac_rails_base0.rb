# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/simple_cache'
require 'avm/eac_rails_base0/instance'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::EacRubyUtils::Console::DocoptRunner
        runner_with

        runner_definition do
          desc 'Utilities for EacRailsBase0 instances.'
          pos_arg :instance_id
          subcommands
        end

        private

        def instance_uncached
          ::Avm::EacRailsBase0::Instance.by_id(options['<instance_id>'])
        end
      end
    end
  end
end
