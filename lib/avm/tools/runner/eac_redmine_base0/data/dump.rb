# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner/data/dump'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          class Dump < ::Avm::EacWebappBase0::Runner::Data::Dump
          end
        end
      end
    end
  end
end
