# frozen_string_literal: true

require 'avm/sources/runner'
require 'eac_cli/core_ext'

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
