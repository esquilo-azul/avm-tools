# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Git
    class Commit
      include ::EacRubyUtils::SimpleCache

      FIELDS = {
        author_name: '%an', author_email: '%ae', author_date: '%ai',
        subject: '%s',
        author_all: '%an <%ae>, %ai',
        commiter_name: '%cn', commiter_email: '%ce', commiter_date: '%ci',
        commiter_all: '%cn <%ce>, %ci'
      }.freeze

      attr_reader :git, :sha1

      def initialize(git, sha1)
        @git = git
        @sha1 = sha1
      end

      def format(format)
        git.execute!('--no-pager', 'log', '-1', "--pretty=format:#{format}", sha1).strip
      end

      FIELDS.each do |field, format|
        define_method field do
          format(format)
        end
      end

      def files_uncached
        diff_tree_execute.each_line.map { |line| ::Avm::Git::Commit::File.new(git, line) }
      end

      def files_size_uncached
        files.inject(0) { |a, e| a + e.dst_size }
      end

      def root_child?
        format('%P').blank?
      end

      private

      def diff_tree_execute
        args = []
        args << '--root' if root_child?
        args << sha1
        git.execute!(*::Avm::Git::Commit::DiffTreeLine::GIT_COMMAND_ARGS, *args)
      end
    end
  end
end
