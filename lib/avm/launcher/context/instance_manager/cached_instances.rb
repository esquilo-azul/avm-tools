# frozen_string_literal: true

require 'avm/launcher/instances/base'

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstances
          def initialize(context, content)
            @context = context
            @content = content
            @instances = {}
          end

          def instances
            @content.keys.map { |k| by_logical_path(k) }
          end

          def by_logical_path(key)
            return @instances[key] if @instances.key?(key)

            h = @content[key]
            parent_instance = h[:parent] ? by_logical_path(h[:parent]) : nil
            path = ::EacLauncher::Paths::Logical.from_h(@context, h)
            @instances[key] = ::Avm::Launcher::Instances::Base.instanciate(path, parent_instance)
          end
        end
      end
    end
  end
end
