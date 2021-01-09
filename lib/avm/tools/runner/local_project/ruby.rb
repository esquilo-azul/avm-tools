# frozen_string_literal: true

require 'avm/patches/eac_ruby_gems_utils/gem'
require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class Ruby < ::EacRubyUtils::Console::DocoptRunner
          require_sub __FILE__
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Ruby utitilies for local projects.'
            subcommands
          end
        end
      end
    end
  end
end
