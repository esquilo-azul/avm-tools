# frozen_string_literal: true

require 'avm/source_stereotypes/tester'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module Avm
  module SourceStereotypes
    class Base
      common_constructor :source

      def name
        self.class.name
      end

      # @return [Avm::SourceStereotypes::Tester]
      def tester
        tester_class.new(self)
      end

      # @return [Class<Avm::SourceStereotypes::Tester>
      def tester_class
        Avm::SourceStereotypes::Tester
      end

      def to_s
        name
      end

      def valid?
        true
      end
    end
  end
end
