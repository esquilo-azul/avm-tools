# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Tester
      enable_abstract_methods
      common_constructor :source

      abstract_methods :result, :logs

      # @return [EacFs::Logs]
      def logs
        raise_abstract_method __method__
      end

      # @return [Avm::Sources::Tests::Result]
      def result
        raise_abstract_method __method__
      end
    end
  end
end
