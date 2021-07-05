# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Launcher
    module Instances
      class RunnerHelper
        def context
          @context ||= ::Avm::Launcher::Context.current
        end

        def find_instances(instance_name)
          context.instances.select { |instance| instance_match?(instance, instance_name) }
        end

        def instance_match?(instance, instance_name)
          ::File.fnmatch?(instance_name, instance.name)
        end

        def instances
          if parsed.all?
            context.instances
          elsif parsed.pending?
            context.pending_instances
          else
            parsed.instance_path.flat_map { |p| find_instances(p) }
          end
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
