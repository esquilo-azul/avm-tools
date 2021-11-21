# frozen_string_literal: true

require 'avm/eac_generic_base0/sources/base'

module Avm
  module EacWebappBase0
    module Sources
      class Base < ::Avm::EacGenericBase0::Sources::Base
        def valid?
          false
        end
      end
    end
  end
end
