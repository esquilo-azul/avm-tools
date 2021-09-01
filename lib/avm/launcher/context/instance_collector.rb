# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    class Context
      class InstanceCollector
        common_constructor :context

        def add_all
          instances_set.merge(context.instances)
          self
        end

        def add_path(path)
          instances_set.merge(instances_on_path(path))
          self
        end

        def add_pending
          instances_set.merge(context.pending_instances)
          self
        end

        def instances
          instances_set.to_a
        end

        private

        def instance_match?(instance, instance_name)
          ::File.fnmatch?(instance_name, instance.name)
        end

        def instances_on_path(path)
          context.instances.select { |instance| instance_match?(instance, path) }
        end

        def instances_set
          @instances_set ||= ::Set.new
        end
      end
    end
  end
end
