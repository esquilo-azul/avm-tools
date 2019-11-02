# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/require_sub'
require 'avm/configs'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Instances
    module Entries
      def path_prefix
        @path_prefix ||= [id].freeze
      end

      def read_entry(entry_suffix, options = {})
        entry(entry_suffix, options).value
      end

      def full_entry_path(entry_suffix)
        unless entry_suffix.is_a?(::Array)
          entry_suffix = ::EacRubyUtils::PathsHash.parse_entry_key(entry_suffix.to_s)
        end
        (path_prefix + entry_suffix).join('.')
      end

      private

      def entry(suffix, options)
        ::Avm::Instances::Entries::EntryReader.new(self, suffix, options)
      end
    end
  end
end
