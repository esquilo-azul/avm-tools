# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Test < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Test local project.'
          end

          def run
            context(:instance_banner)
            infov 'Test command', test_command
            if test_command.present?
              test_command.system!
            else
              fatal_error 'No test command found'
            end
          end

          def test_command
            context(:instance).configuration.if_present(&:any_test_command)
          end
        end
      end
    end
  end
end
