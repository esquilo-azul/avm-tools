# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/runner/data/load'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          class Load < ::Avm::Stereotypes::EacWebappBase0::Runner::Data::Load
          end
        end
      end
    end
  end
end
