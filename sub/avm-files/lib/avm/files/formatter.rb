# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_fs/traversable'

module Avm
  module Files
    class Formatter
      include ::EacFs::Traversable
      require_sub __FILE__
      enable_simple_cache
      enable_speaker
      enable_listable
      lists.add_symbol :option, :apply, :recursive, :verbose
      common_constructor :source_paths, :options, default: [{}] do
        options.assert_valid_keys(self.class.lists.option.values)
      end

      FORMATS = %w[ruby php html python xml javascript json generic_plain].freeze

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
          next unless options[OPTION_APPLY]

          @result += format.apply(files)
        end
      end

      def traverser_check_file(file)
        format = find_format(file)
        infov file, format ? format.class : '-' if options[OPTION_VERBOSE]
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

      def search_files
        infov 'Directories to search', source_paths.count
        source_paths.each do |source_path|
          infom "Searching files on \"#{source_path}\"..."
          traverser_check_path(source_path)
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

      def traverser_recursive
        options[OPTION_RECURSIVE]
      end
    end
  end
end
