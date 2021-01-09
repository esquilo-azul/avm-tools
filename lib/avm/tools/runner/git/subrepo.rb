# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class Git
        class Subrepo < ::EacRubyUtils::Console::DocoptRunner
          require_sub __FILE__
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Git-subrepo (https://github.com/ingydotnet/git-subrepo) utilities.'
            subcommands
          end
        end
      end
    end
  end
end
