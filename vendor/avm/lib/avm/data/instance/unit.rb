# frozen_string_literal: true

require 'avm/data/unit'

module Avm
  module Data
    module Instance
      class Unit < ::Avm::Data::Unit
        attr_reader :instance

        def initialize(instance)
          @instance = instance
        end
      end
    end
  end
end
