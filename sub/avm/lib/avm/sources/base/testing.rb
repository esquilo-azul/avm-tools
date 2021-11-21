# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Testing
        # @return [Avm::SourceStereotypes::Tester]
        def tester
          tester_class.new(stereotype)
        end

        # @return [Class<Avm::SourceStereotypes::Tester>
        def tester_class
          Avm::SourceStereotypes::Tester
        end
      end
    end
  end
end
