# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyUtils
  class PathsHash
    require_sub __FILE__

    class << self
      def parse_entry_key(entry_key)
        r = entry_key.to_s.strip
        raise ::EacRubyUtils::PathsHash::EntryKeyError, 'Entry key cannot start or end with dot' if
        r.start_with?('.') || r.end_with?('.')

        r = r.split('.').map(&:strip)
        if r.empty?
          raise ::EacRubyUtils::PathsHash::EntryKeyError, "Entry key \"#{entry_key}\" is empty"
        end
        return r.map(&:to_sym) unless r.any?(&:blank?)

        raise ::EacRubyUtils::PathsHash::EntryKeyError,
              "Entry key \"#{entry_key}\" has at least one blank part"
      end
    end

    attr_reader :root

    def initialize(source_hash = {})
      @root = Node.new(source_hash)
    end

    def [](entry_key)
      root.read_entry(::EacRubyUtils::PathsHash::PathSearch.parse_entry_key(entry_key))
    end

    def []=(entry_key, entry_value)
      root.write_entry(
        ::EacRubyUtils::PathsHash::PathSearch.parse_entry_key(entry_key), entry_value
      )
    end

    def fetch(entry_key)
      root.fetch(::EacRubyUtils::PathsHash::PathSearch.parse_entry_key(entry_key))
    end

    def key?(entry_key)
      root.entry?(::EacRubyUtils::PathsHash::PathSearch.parse_entry_key(entry_key))
    end

    delegate :to_h, to: :root

    private

    attr_reader :data
  end
end
