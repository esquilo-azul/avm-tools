# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        require_sub __FILE__

        def subject
          source
        end
      end
    end
  end
end
