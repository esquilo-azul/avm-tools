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
        registered_modules.lazy.map { |klass| klass.new(*registered_initialize_args) }
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
        (single_registered_modules + provider_registered_modules)
          .select { |v| valid_registered_module?(v) }.uniq.sort_by { |s| [s.name] }
      end

      def single_registered_modules
        single_instance_registry.registered.map(&:registered_module)
      end

      def provider_registered_modules
        provider_registry.registered.map(&:registered_module).flat_map do |provider_class|
          provider_class.new.all
        end
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
