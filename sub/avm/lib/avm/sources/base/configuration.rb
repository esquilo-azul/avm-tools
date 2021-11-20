# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Configuration
        private

        # @return [Avm::Sources::Configuration]
        def configuration_uncached
          ::Avm::Sources::Configuration.find_in_path(path) || ::Avm::Sources::Configuration.new
        end
      end
    end
  end
end
