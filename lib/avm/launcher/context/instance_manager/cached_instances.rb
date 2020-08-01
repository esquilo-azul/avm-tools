# frozen_string_literal: true

require 'avm/launcher/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstances
          enable_simple_cache
          common_constructor :context, :content

          def instances
            content.keys.map { |k| by_logical_path(k) }
          end

          def by_logical_path(key)
            cached_instances[key].if_blank do
              cached_instances[key] = build_by_logical_path(content.fetch(key))
            end
          end

          private

          def cached_instances_uncached
            {}
          end

          def build_by_logical_path(instance_data)
            parent_instance = instance_data[:parent] ? by_logical_path(instance_data[:parent]) : nil
            path = ::EacLauncher::Paths::Logical.from_h(context, instance_data)
            ::Avm::Launcher::Instances::Base.instanciate(path, parent_instance)
          end
        end
      end
    end
  end
end
