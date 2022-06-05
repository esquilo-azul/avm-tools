# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/gems_registry'

module Avm
  module Registry
    class Base
      enable_simple_cache
      common_constructor :module_suffix

      def detect(*registered_initialize_args)
        detect_optional(*registered_initialize_args) ||
          raise("No registered module valid for #{registered_initialize_args}" \
            " (Module suffix: #{module_suffix}, Available: #{registered_modules.join(', ')})")
      end

      def detect_optional(*registered_initialize_args)
        registered_modules.reverse.lazy.map { |klass| klass.new(*registered_initialize_args) }
          .find(&:valid?)
      end

      def provider_module_suffix
        "#{module_suffix}::Provider"
      end

      def single_module_suffix
        "#{module_suffix}::Base"
      end

      def to_s
        "#{self.class}[#{module_suffix}]"
      end

      def valid_registered_module?(a_module)
        a_module.is_a?(::Class) && !a_module.abstract?
      end

      private

      def registered_modules_uncached
        registered_gems.flat_map { |registry| modules_from_registry(registry) }
          .select { |v| valid_registered_module?(v) }.uniq
      end

      def modules_from_registry(registry)
        if registry.registry.module_suffix == provider_module_suffix
          registry.registered_module.new.all
        else
          [registry.registered_module]
        end
      end

      def registered_gems
        (single_instance_registry.registered + provider_registry.registered).sort
      end

      def single_instance_registry_uncached
        ::EacRubyUtils::GemsRegistry.new(single_module_suffix)
      end

      def provider_registry_uncached
        ::EacRubyUtils::GemsRegistry.new(provider_module_suffix)
      end
    end
  end
end
