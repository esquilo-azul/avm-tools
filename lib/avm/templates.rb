# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Templates
    class << self
      def template(subpath, required = true)
        path = template_path(subpath)
        if path.blank?
          return nil unless required

          raise "Template not found for subpath \"#{subpath}\" (Included paths: #{included_paths})"
        end
        return ::Avm::Templates::File.new(path) if ::File.file?(path)
        return ::Avm::Templates::Directory.new(path) if ::File.directory?(path)

        raise 'Invalid branching'
      end

      # @return The absolute path of template if found, +nil+ otherwise.
      def template_path(subpath)
        included_paths.each do |included_path|
          r = search_template_in_included_path(included_path, subpath)
          return r if r
        end
        nil
      end

      def included_paths
        @included_paths ||= ::Set.new([::File.expand_path('../../template', __dir__)])
      end

      private

      def search_template_in_included_path(included_path, subpath)
        path = ::File.join(included_path, subpath)
        dir = ::File.dirname(path)
        Dir.entries(dir).each do |entry|
          next if %w[. ..].include?(entry)
          return path if template_basename(entry) == ::File.basename(subpath)
        end
      end

      def template_basename(entry)
        entry.gsub(/(?:\.[a-z0-9]+)+\z/i, '')
      end
    end
  end
end
