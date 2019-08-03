# frozen_string_literal: true

require 'eac_ruby_utils/patches/object/asserts'
require 'avm/configs'

module Avm
  module Instances
    module Entries
      def path_prefix
        @path_prefix ||= [id].freeze
      end

      def read_entry(entry_suffix, options = {})
        ::Avm.configs.read_entry(full_entry_path(entry_suffix), options)
      end

      def full_entry_path(entry_suffix)
        unless entry_suffix.is_a?(::Array)
          entry_suffix = ::EacRubyUtils::PathsHash.parse_entry_key(entry_suffix.to_s)
        end
        (path_prefix + entry_suffix).join('.')
      end
    end
  end
end
