# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/filesystem_traverser'

module Avm
  module Files
    class Formatter
      require_sub __FILE__
      enable_simple_cache
      enable_console_speaker
      common_constructor :source_paths, :options

      FORMATS = %w[php generic_plain].freeze

      def run
        clear
        search_files
        apply
        show_results
      end

      private

      def apply
        infom "Applying #{@formats_files.count} format(s)... "
        @formats_files.each do |format, files|
          infom "Applying format #{format.name} (Files matched: #{files.count})..."
          next unless options.fetch(:apply)

          @result += format.apply(files)
        end
      end

      def check_file(file)
        format = find_format(file)
        infov file, format ? format.class : '-' if options.fetch(:verbose)
        return unless format

        @formats_files[format] ||= []
        @formats_files[format] << file
      end

      def clear
        @formats_files = {}
        @result = []
      end

      def find_format(file)
        formats.each do |c|
          return c if c.match?(file)
        end
        nil
      end

      def formats_uncached
        FORMATS.map do |identifier|
          "avm/files/formatter/formats/#{identifier}".camelize.constantize.new
        end
      end

      def fs_traverser_uncached
        r = ::EacRubyUtils::FilesystemTraverser.new
        r.check_file = method(:check_file)
        r.recursive = options.fetch(:recursive)
        r
      end

      def search_files
        infov 'Directories to search', source_paths.count
        source_paths.each do |source_path|
          infom "Searching files on \"#{source_path}\"..."
          fs_traverser.check_path(source_path)
        end
      end

      def show_results
        changed = @result.select(&:changed)
        changed.each do |h|
          out h.file.to_s.cyan
          out " (#{h.format})".yellow
          puts ' changed'.green
        end
        infov('Files changed', "#{changed.count}/#{@result.count}")
      end
    end
  end
end
