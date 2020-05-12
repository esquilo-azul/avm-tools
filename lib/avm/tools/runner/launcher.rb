# frozen_string_literal: true

require 'eac_launcher/runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Launcher < ::EacLauncher::Runner
      end
    end
  end
end
