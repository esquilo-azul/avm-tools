# frozen_string_literal: true

require 'active_support/core_ext/string/filters'
require 'eac_ruby_utils/fs/temp'
require 'filesize'

module EacFs
  module Logs
    TRUNCATE_DEFAULT_LENGTH = 1000
    TRUNCATE_APPEND_TEXT = '(...) '

    # @param label [Symbol]
    # @return [EacRubyUtils::Fs::Temp::File]
    def [](label)
      log_set.fetch(sanitize_label(label))
    end

    # @param label [Symbol]
    # @return [EacFs::Logs]
    def add(label)
      log_set[sanitize_label(label)] = ::EacRubyUtils::Fs::Temp.file

      self
    end

    # @return [EacFs::Logs]
    def remove_all
      log_set.each_key { |label| remove(label) }

      self
    end

    # @param label [Symbol]
    def remove(label)
      log_set.fetch(sanitize_label(label)).remove
      log_set.delete(sanitize_label(label))
    end

    # @param label [Symbol]
    # @param length [Integer]
    # @return [String]
    def truncate(label, length = TRUNCATE_DEFAULT_LENGTH)
      content = self[label].read.strip
      return content if content.length <= TRUNCATE_DEFAULT_LENGTH

      TRUNCATE_APPEND_TEXT + content[content.length - length + TRUNCATE_APPEND_TEXT.length,
        length - TRUNCATE_APPEND_TEXT.length]
    end

    # @param length [Integer]
    # @return [String]
    def truncate_all(length = TRUNCATE_DEFAULT_LENGTH)
      s = "Files: #{log_set.length}\n"
      log_set.each do |label, path|
        x = truncate(label, length)
        y = [label, path, ::Filesize.from("#{path.size} B").pretty].join(' / ')
        s += x.blank? ? ">>> #{y} (Blank) <<<" : ">>> #{y}\n#{x}\n<<< #{y}\n"
      end
      s
    end

    private

    # @param label [Object]
    # @return [Symbol]
    def sanitize_label(label)
      label.to_sym
    end

    # @return [Hash<Symbol, EacRubyUtils::Fs::Temp::File>]
    def log_set
      @log_set ||= {}
    end
  end
end
