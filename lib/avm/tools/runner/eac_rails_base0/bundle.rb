# frozen_string_literal: true

require 'avm/eac_rails_base1/runner/bundle'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::Avm::EacRailsBase1::Runner
        class Bundle < ::Avm::EacRailsBase1::Runner::Bundle
        end
      end
    end
  end
end
