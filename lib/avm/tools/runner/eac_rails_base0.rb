# frozen_string_literal: true

require 'avm/eac_rails_base0'
require 'avm/eac_rails_base1/runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class EacRailsBase0 < ::Avm::EacRailsBase1::Runner
        require_sub __FILE__
      end
    end
  end
end
