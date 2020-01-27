# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/runner/data'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::Avm::Stereotypes::EacWebappBase0::Runner::Data
        end
      end
    end
  end
end
