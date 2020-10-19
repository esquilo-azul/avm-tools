# frozen_string_literal: true

module EacRubyUtils
  class PathsHash
    class PathSearch
      class << self
        def parse_entry_key(string)
          new(::EacRubyUtils::PathsHash.parse_entry_key(string), [])
        end
      end

      common_constructor :current, :previous do
        self.current = current.assert_argument(Array, 'current').freeze
        self.previous = previous.assert_argument(Array, 'previous')
        raise ::EacRubyUtils::PathsHash::EntryKeyError, 'Current is empty' if current.empty?
      end

      def cursor
        current.first
      end

      def ended?
        current.count <= 1
      end

      def raise_error(message)
        raise ::EacRubyUtils::PathsHash::EntryKeyError, "#{message} (#{self})"
      end

      def succeeding
        self.class.new(current[1..-1], previous + [cursor])
      end

      def to_s
        "#{self.class}[Current: #{current}, Previous: #{previous}]"
      end
    end
  end
end
