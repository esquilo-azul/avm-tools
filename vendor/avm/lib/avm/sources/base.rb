# frozen_string_literal: true

require 'avm/registry'
require 'eac_git'
require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      require_sub __FILE__
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :parent
      common_constructor :path, :options, default: [{}] do
        self.path = path.to_pathname
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      delegate :to_s, to: :path

      # @return [Avm::Sources::Base]
      def parent
        options[OPTION_PARENT]
      end

      # @return [Pathname]
      def relative_path
        return path if parent.blank?

        path.relative_path_from(parent.path)
      end

      # @return [Enumerable<Avm::Sources::Base>]
      def subs
        git_repo.subrepos
                .map { |subrepo| self.class.new(subrepo.subpath.expand_path(path), parent: self) }
      end

      private

      # @return [EacGit::Local]
      def git_repo_uncached
        ::EacGit::Local.new(path)
      end

      # @return [Avm::Scms::Base]
      def scm_uncached
        ::Avm::Registry.scms.detect(path)
      end

      # @return [Avm::SourceStereotypes::Base]
      def stereotype_uncached
        ::Avm::Registry.source_stereotypes.detect(self)
      end
    end
  end
end
