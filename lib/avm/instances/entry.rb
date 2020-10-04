# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    class Entry
      common_constructor :parent, :suffix, :options

      def auto_value
        parent.respond_to?(auto_value_method, true) ? parent.send(auto_value_method) : nil
      end

      def auto_value_method
        "auto_#{suffix.to_s.gsub('.', '_')}"
      end

      def full_path
        (parent.path_prefix + suffix_as_array).join('.')
      end

      def optional_value
        read(required: false, noinput: true) || auto_value
      end

      def read(extra_options = {})
        ::Avm.configs.read_entry(full_path, options.merge(extra_options))
      end

      def suffix_as_array
        if suffix.is_a?(::Array)
          suffix.dup
        else
          ::EacRubyUtils::PathsHash.parse_entry_key(suffix.to_s)
        end
      end

      def value
        optional_value || read
      end
    end
  end
end
