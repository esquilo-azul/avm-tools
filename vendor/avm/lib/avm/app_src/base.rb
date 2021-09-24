# frozen_string_literal: true

require 'eac_git'
require 'eac_ruby_utils/core_ext'

module Avm
  module AppSrc
    class Base
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :parent
      common_constructor :path, :options, default: [{}] do
        self.path = path.to_pathname
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      delegate :to_s, to: :path

      # @return [Avm::AppSrc::Base]
      def parent
        options[OPTION_PARENT]
      end

      # @return [Pathname]
      def relative_path
        return path if parent.blank?

        path.relative_path_from(parent.path)
      end

      # @return [Enumerable<Avm::AppSrc::Base>]
      def subs
        git_repo.subrepos
                .map { |subrepo| self.class.new(subrepo.subpath.expand_path(path), parent: self) }
      end

      private

      # @return [EacGit::Local]
      def git_repo_uncached
        ::EacGit::Local.new(path)
      end
    end
  end
end
