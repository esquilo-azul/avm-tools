# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacGit
  class Local
    class Commit
      require_sub __FILE__, include_modules: true
      enable_simple_cache
      include ::Comparable

      FIELDS = {
        author_name: '%an', author_email: '%ae', author_date: '%ai',
        subject: '%s',
        author_all: '%an <%ae>, %ai',
        commit_hash: '%H',
        commiter_name: '%cn', commiter_email: '%ce', commiter_date: '%ci',
        commiter_all: '%cn <%ce>, %ci',
        raw_body: '%B'
      }.freeze

      common_constructor :repo, :id

      def <=>(other)
        [repo, id] <=> [other.repo, other.id]
      end

      def format(format)
        repo.command('--no-pager', 'log', '-1', "--pretty=format:#{format}", id).execute!.strip
      end

      FIELDS.each do |field, format|
        define_method(field) { format(format) }
      end

      def changed_files_uncached
        diff_tree_execute.each_line.map do |line|
          ::EacGit::Local::Commit::ChangedFile.new(self, line)
        end
      end

      def changed_files_size_uncached
        changed_files.inject(0) { |a, e| a + e.dst_size }
      end

      # @return [EacGit::Local::Commit, nil]
      def parent
        ps = parents
        raise "#{self} has more than one parent" if ps.count > 2

        ps.empty? ? nil : ps.first
      end

      # @return [Array<EacGit::Local::Commit>]
      def parents
        format('%P').each_line.map { |line| repo.commitize(line) }
      end

      def root_child?
        parents.empty?
      end

      private

      def diff_tree_execute
        args = []
        args << '--root' if root_child?
        args << id
        repo.command(*::EacGit::Local::Commit::DiffTreeLine::GIT_COMMAND_ARGS, *args).execute!
      end
    end
  end
end
