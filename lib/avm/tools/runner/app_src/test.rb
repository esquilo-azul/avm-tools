# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Test
          runner_with :help do
            desc 'Test local project.'
          end

          def run
            runner_context.call(:instance_banner)
            infov 'Test command', test_command
            if test_command.present?
              test_command.system!
            else
              fatal_error 'No test command found'
            end
          end

          def test_command
            runner_context.call(:instance).configuration.if_present(&:any_test_command)
          end
        end
      end
    end
  end
end
