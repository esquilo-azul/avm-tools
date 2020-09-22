# frozen_string_literal: true

require 'avm/eac_redmine_base0/deploy'
require 'avm/eac_webapp_base0/runner/deploy'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Deploy < ::Avm::EacWebappBase0::Runner::Deploy
        end
      end
    end
  end
end
