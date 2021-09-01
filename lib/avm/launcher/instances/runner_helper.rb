# frozen_string_literal: true

require 'avm/launcher/context'
require 'avm/tools/core_ext'
require 'avm/launcher/context/instance_collector'

module Avm
  module Launcher
    module Instances
      module RunnerHelper
        def context
          @context ||= ::Avm::Launcher::Context.current
        end

        def instances
          collector = ::Avm::Launcher::Context::InstanceCollector.new(context)
          if parsed.all?
            collector.add_all
          elsif parsed.pending?
            collector.add_pending
          else
            parsed.instance_path.flat_map { |p| collector.add_path(p) }
          end
          collector.instances
        end

        def instance_stereotypes(instance)
          instance.stereotypes.map(&:label).join(', ')
        end

        def instance_label(instance)
          "#{instance.name} [#{instance_stereotypes(instance)}]"
        end
      end
    end
  end
end
