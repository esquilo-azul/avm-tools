# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Testing
        # @return [Avm::Sources::Tester]
        def tester
          tester_class.new(stereotype)
        end

        # @return [Class<Avm::Sources::Tester>
        def tester_class
          Avm::Sources::Tester
        end
      end
    end
  end
end
