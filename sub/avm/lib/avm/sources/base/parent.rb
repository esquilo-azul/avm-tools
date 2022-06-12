# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Parent
        # @return [Avm::Sources::Base]
        def parent
          options[OPTION_PARENT]
        end
      end
    end
  end
end
