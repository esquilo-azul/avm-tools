# frozen_string_literal: true

require 'avm/instances/base'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Instance < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__
        runner_with

        runner_definition do
          desc 'Utilities for generic instances.'
          pos_arg :instance_id
          subcommands
        end

        private

        def instance_uncached
          ::Avm::Instances::Base.by_id(options['<instance_id>'])
        end
      end
    end
  end
end
