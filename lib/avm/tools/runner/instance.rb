# frozen_string_literal: true

require 'avm/instances/base'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Utilities for generic instances.'
          pos_arg :instance_id
          subcommands
        end

        def extra_available_subcommands
          instance.if_present({}, &:extra_available_subcommands)
        end

        private

        def instance_uncached
          ::Avm::Instances::Base.by_id(parsed.instance_id)
        end
      end
    end
  end
end
