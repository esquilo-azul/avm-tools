# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Parent
        # @return [Avm::Sources::Base]
        def parent
          parent_by_option
        end

        # @return [Avm::Sources::Base]
        def parent_by_option
          options[OPTION_PARENT]
        end
      end
    end
  end
end
