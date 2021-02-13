# frozen_string_literal: true

require 'avm/git/auto_commit/commit_info'
require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    class FileAutoFixup
      enable_console_speaker
      enable_simple_cache
      enable_listable

      common_constructor :git, :path, :rules

      COMMITS_SEARCH_INTERVAL = 'origin/master..HEAD'

      def run
        start_banner
        run_commit || warn("No rule returned commit information for \"#{path}\"")
      end

      private

      def commit_args
        commit_info.if_present([], &:git_commit_args) + ['--', path]
      end

      def commit_info_uncached
        rules.lazy.map { |rule| rule.with_file(self).commit_info }.find(&:present?)
      end

      def start_banner
        infov 'Path', path
        infov '  Commits found', commits.count
      end

      def run_commit
        return false if commit_info.blank?

        infov '  Commit arguments', ::Shellwords.join(commit_args)
        git.execute!('commit', *commit_args)
        success '  Commited'
        true
      end

      def commits_uncached
        git.execute!('log', '--pretty=format:%H', COMMITS_SEARCH_INTERVAL, '--', path)
           .each_line.map { |sha1| ::Avm::Git::Commit.new(git, sha1.strip) }
           .reject { |commit| commit.subject.start_with?('fixup!') }
           .each_with_index.map { |commit, index| CommitDelegator.new(commit, index) }
      end

      class CommitDelegator < ::SimpleDelegator
        attr_reader :index

        def initialize(commit, index)
          super(commit)
          @index = index
        end

        def position
          index + 1
        end
      end
    end
  end
end
