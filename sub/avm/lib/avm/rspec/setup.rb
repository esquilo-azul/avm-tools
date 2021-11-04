# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Rspec
    module Setup
      def self.extended(obj)
        obj.setup_in_avm_registry_example
        obj.setup_not_in_avm_registry_example
      end

      def setup_in_avm_registry_example
        require 'avm/rspec/shared_examples/in_avm_registry'
      end

      def setup_not_in_avm_registry_example
        require 'avm/rspec/shared_examples/not_in_avm_registry'
      end
    end
  end
end
