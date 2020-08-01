# frozen_string_literal: true

require 'eac_launcher/publish/check_result'
require('yaml')

module Avm
  module Launcher
    class Context
      class InstanceManager
        include ::EacRubyUtils::SimpleCache

        def initialize(context)
          @context = context
        end

        def publish_state_set(instance, stereotype_name, check_status)
          data = cached_instances_file_content_uncached
          data[instance.logical] ||= {}
          data[instance.logical][:publish_state] ||= {}
          data[instance.logical][:publish_state][stereotype_name] = check_status
          write_cache_file(data)
        end

        def pending_instances
          instances.select { |instance| pending_instance?(instance) }
        end

        private

        def instances_uncached
          (cached_instances || search_instances).select(&:included?)
        end

        def search_instances
          cache_instances(::EacLauncher::Context::InstanceDiscovery.new(@context).instances)
        end

        def cached_instances
          return nil if @context.recache
          return nil unless cached_instances_file_content

          CachedInstances.new(cached_instances_file_content).instances
        end

        def cached_instances_file_content_uncached
          r = YAML.load_file(cache_file_path)
          r.is_a?(::Hash) ? r : nil
        rescue Errno::ENOENT
          nil
        end

        def cache_instances(instances)
          write_cache_file(Hash[instances.map { |i| [i.logical, i.to_h] }])
          instances
        end

        def write_cache_file(data)
          ::File.write(cache_file_path, data.to_yaml)
        end

        def cache_file_path
          ::File.join(@context.cache_root, 'instances.yml')
        end

        def pending_instance?(instance)
          data = cached_instances_file_content
          return false unless data[instance.logical]
          return false unless data[instance.logical][:publish_state].is_a?(Hash)

          data[instance.logical][:publish_state].any? do |_k, v|
            ::EacLauncher::Publish::CheckResult.pending_status?(v)
          end
        end

        class CachedInstances
          def initialize(content)
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
