# frozen_string_literal: true

require 'avm/git/auto_commit/commit_info'
require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    class FileAutoFixup
      enable_console_speaker
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :select, :unique

      common_constructor :git, :path, :options, default: [{}] do
        self.options = self.class.lists.option.hash_keys_validate!(options.symbolize_keys)
      end

      COMMIT_FORMAT = '%h - %s (%cr)'
      COMMITS_SEARCH_INTERVAL = 'origin/master..HEAD'
      SKIP_OPTION = 's'

      def run
        start_banner
        run_commit || warn("No rule returned commit information for \"#{path}\"")
      end

      private

      def commit_args
        commit_info.if_present([], &:git_commit_args) + ['--', path]
      end

      def commit_info_uncached
        return nil if commits.count.zero?

        [selected_commit_by_unique, select_commit_by_select, select_commit].lazy.map do |v|
          v.if_present { |w| ::Avm::Git::AutoCommit::CommitChoose.new.fixup(w) }
        end.find
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

      def select_commit
        commits_banner
        request_input('Which commit?', list: commits_by_position)
      end

      def selected_commit_by_unique
        return unless options[OPTION_UNIQUE]
        return commits.first if commits.first
      end

      def select_commit_by_select
        options[OPTION_SELECT].if_present(&:to_i).if_present do |v|
          commits.find { |commit| commit.position == v }
        end
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
