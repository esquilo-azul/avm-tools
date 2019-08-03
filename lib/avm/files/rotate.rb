# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'eac_ruby_utils/simple_cache'

module Avm
  module Files
    class Rotate
      include ::EacRubyUtils::SimpleCache

      attr_reader :source_path

      def initialize(source_path)
        @source_path = source_path
      end

      def run
        validate_msg = validate
        return validate_msg if validate_msg.present?

        ::FileUtils.mv(source_path, target_path)
        nil
      end

      private

      def validate
        return 'Source not exist' unless ::File.exist?(source_path)
        return 'Already rotated' if source_rotated?

        nil
      end

      def source_rotated?
        source_basename_without_extension.match(/[PN]\d{4}\z/)
      end

      def source_extension_uncached
        file_extension(::File.basename(source_path))
      end

      def source_basename_without_extension
        ::File.basename(source_path, source_extension)
      end

      def target_path_uncached
        ::File.join(::File.dirname(source_path), target_basename)
      end

      def target_basename
        source_basename_without_extension + target_suffix + source_extension
      end

      def target_suffix
        return '_UNKNOWN_MTIME' unless ::File.exist?(source_path)

        t = ::File.mtime(source_path)
        t.strftime('_%Y-%m-%d_%H-%M-%S_') + t.strftime('%z').gsub(/\A\+/, 'P').gsub(/\A\-/, 'N')
      end

      def file_extension(basename)
        extension = ::File.extname(basename)
        return '' if extension.blank?

        file_extension(::File.basename(basename, extension)) + extension
      end
    end
  end
end
