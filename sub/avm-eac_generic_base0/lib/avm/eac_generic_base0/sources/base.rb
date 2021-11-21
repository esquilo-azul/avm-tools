# frozen_string_literal: true

require 'avm/eac_generic_base0/sources/tester'
require 'avm/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    module Sources
      class Base < ::Avm::Sources::Base
        # @return [Avm::EacGenericBase0::Sources::Tester]
        def tester_class
          Avm::EacGenericBase0::Sources::Tester
        end

        def valid?
          path.directory?
        end
      end
    end
  end
end
