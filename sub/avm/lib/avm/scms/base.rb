# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class Base
      enable_abstract_methods
      enable_simple_cache
      abstract_methods :update, :valid?
      common_constructor :path do
        self.path = path.to_pathname
      end

      # @return [Avm::Scms::Commit,NilClass]
      def commit_if_change(_message = nil)
        raise_abstract_method __method__
      end

      def name
        self.class.name.demodulize
      end

      # @return [Enumerable<Avm::Scms::Base>]
      def subs
        raise_abstract_method __method__
      end

      def to_s
        name
      end

      private

      # @return [Avm::Scms::Base]
      def parent_scm_uncached
        ::Avm::Registry.scms.detect_by_path_optional(path.parent)
      end
    end
  end
end
