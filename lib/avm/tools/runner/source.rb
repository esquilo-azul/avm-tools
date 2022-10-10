# frozen_string_literal: true

require 'avm/sources/runner'
require 'avm/tools/source'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        require_sub __FILE__

        def subject
          source
        end

        private

        def instance_uncached
          ::Avm::Tools::Source.new(source_path)
        end
      end
    end
  end
end
