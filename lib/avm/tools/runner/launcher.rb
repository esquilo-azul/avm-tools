# frozen_string_literal: true

require 'eac_launcher/runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Launcher < ::EacLauncher::Runner
        require_sub __FILE__
      end
    end
  end
end
