# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module SourceStereotypes
    class Base
      enable_abstract_methods
      abstract_methods :valid?
      common_constructor :source

      def name
        self.class.name
      end

      def to_s
        name
      end
    end
  end
end
