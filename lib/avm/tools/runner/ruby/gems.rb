# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Ruby < ::EacRubyUtils::Console::DocoptRunner
        class Gems < ::EacRubyUtils::Console::DocoptRunner
          require_sub __FILE__
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Rubygems utilities for AVM.'
            subcommands
          end
        end
      end
    end
  end
end
