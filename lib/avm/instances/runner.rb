# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Instances
    class Runner < ::EacRubyUtils::Console::DocoptRunner
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

      runner_with
      description = "Utilities for #{stereotype_name} instances."
      runner_definition do
        desc description
        pos_arg 'instance-id'
        subcommands
      end

      delegate :instance_class, :stereotype_module, :stereotype_name, to: :class

      private

      def instance_uncached
        self.class.instance_class.by_id(options.fetch('<instance-id>'))
      end
    end
  end
end
