# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    class FileAutoFixup
      enable_console_speaker
      enable_simple_cache

      common_constructor :git, :path

      COMMIT_FORMAT = '%h - %s (%cr)'
      COMMITS_SEARCH_INTERVAL = 'origin/master..HEAD'
      SKIP_OPTION = 's'

      def run
        start_banner
        if commits.count.zero?
          run_no_commits_found
        elsif commits.count == 1
          fixup_commit(commits.first)
        else
          run_commits_selection
        end
      end

      private

      def start_banner
        infov 'Path', path
        infov '  Commits found', commits.count
      end

      def run_no_commits_found
        infom '  No commits found'
      end

      def fixup_commit(commit)
        infov '  Commit selected/found', format_commit(commit)
        git.execute!('commit', '--fixup', commit.sha1, '--', path)
        success "  Fixup with \"#{format_commit(commit)}\""
      end

      def run_commits_selection
        selected_commit = select_commit
        if selected_commit
          fixup_commit(selected_commit)
        else
          infom '  Skipped'
        end
      end

      def select_commit
        commits_banner
        request_input('Which commit?', list: commits_by_position)
      end

      def commits_banner
        commits.each_with_index do |commit, _index|
          infov "    #{commit.position}", format_commit(commit)
        end
        infov "    #{SKIP_OPTION}", 'skip'
      end

      def commits_by_position
        (commits.map { |commit| [commit.position.to_s, commit] } + [[SKIP_OPTION, nil]]).to_h
      end

      def commits_uncached
        git.execute!('log', '--pretty=format:%H', COMMITS_SEARCH_INTERVAL, '--', path)
           .each_line.map { |sha1| ::Avm::Git::Commit.new(git, sha1.strip) }
           .reject { |commit| commit.subject.start_with?('fixup!') }
           .each_with_index.map { |commit, index| CommitDelegator.new(commit, index) }
      end

      def format_commit(commit)
        commit.format(COMMIT_FORMAT)
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
