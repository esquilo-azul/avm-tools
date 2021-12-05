# frozen_string_literal: true

require 'avm/runners/base'
require 'eac_cli/core_ext'

module Avm
  module Instances
    class Runner < ::Avm::Runners::Base
      class << self
        def instance_class
          ::Avm.const_get(stereotype_name).const_get('Instance')
        end

        def stereotype_module
          ::Avm.const_get(stereotype_name)
        end

        def stereotype_name
          name.demodulize
        end
      end

      description = "Utilities for #{stereotype_name} instances."
      runner_with :help, :subcommands do
        desc description
        pos_arg 'instance-id'
        subcommands
      end

      delegate :instance_class, :stereotype_module, :stereotype_name, to: :class

      private

      def instance_uncached
        self.class.instance_class.by_id(parsed.instance_id)
      end
    end
  end
end
