# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Parent
        # @return [Avm::Sources::Base]
        def parent
          parent_by_option || parent_by_search
        end

        # @return [Avm::Sources::Base]
        def parent_by_option
          options[OPTION_PARENT]
        end

        # @return [Avm::Sources::Base]
        def parent_by_search
          parent_path = path.parent
          until parent_path.root?
            ::Avm::Registry.sources.detect_optional(parent_path).if_present { |v| return v }
            parent_path = parent_path.parent
          end
          nil
        end
      end
    end
  end
end
