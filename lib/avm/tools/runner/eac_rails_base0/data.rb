# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner/data'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::Avm::EacWebappBase0::Runner::Data
        end
      end
    end
  end
end
