# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Launcher < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__
        include ::EacCli::DefaultRunner

        runner_definition do
          desc 'Utilities to deploy applications and libraries.'
          subcommands
        end
      end
    end
  end
end
