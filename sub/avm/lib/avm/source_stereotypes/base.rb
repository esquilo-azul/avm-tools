# frozen_string_literal: true

require 'avm/sources/tester'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module Avm
  module SourceStereotypes
    class Base
      common_constructor :source

      def name
        self.class.name
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
