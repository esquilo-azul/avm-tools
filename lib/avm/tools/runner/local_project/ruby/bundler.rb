# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class LocalProject
        class Ruby
          class Bundler < ::EacRubyUtils::Console::DocoptRunner
            require_sub __FILE__
            include ::EacCli::DefaultRunner

            runner_definition do
              desc 'Ruby\'s bundler utitilies for local projects.'
              subcommands
            end
          end
        end
      end
    end
  end
end
