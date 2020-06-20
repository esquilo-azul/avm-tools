# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    class AutoCommitPath
      enable_console_speaker
      common_constructor :git, :path

      CLASS_NAME_PATTERNS = [%r{lib/(.+)\.rb\z}, %r{app/[^/]+/(.+)\.rb\z}].freeze

      def run
        banner
        commit
      end

      def banner
        infom "Checking \"#{relative_path}\""
        infov '  * Class name', class_name
        infov '  * Commit message', commit_message
      end

      def commit
        infom '  * Commiting...'
        git.system!('reset', 'HEAD')
        git.system!('add', '--', relative_path.to_path)
        git.system!('commit', '-m', commit_message, '--', relative_path.to_path)
      end

      def class_name
        CLASS_NAME_PATTERNS.each do |pattern|
          pattern.if_match(relative_path.to_path, false) { |m| return m[1].camelize }
        end
        raise "No pattern matched \"#{relative_path}\""
      end

      def commit_message
        r = class_name
        r += ': remove' unless path.file?
        r + '.'
      end

      def relative_path
        path.relative_path_from(git.root_path)
      end
    end
  end
end
