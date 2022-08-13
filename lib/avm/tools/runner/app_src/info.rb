# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Info
          runner_with :help do
            desc 'Show information about local project instance.'
            bool_opt '-p', '--parent', 'Show the parent source.'
            bool_opt '-t', '--tests', 'Show test commands.'
          end

          def run
            show_source
            show_parent
            show_test_commands
          end

          private

          def show_parent
            return unless parsed.parent?

            infov 'Parent', runner_context.call(:subject).parent
          end

          def show_source
            infov 'Path', runner_context.call(:subject).path
            infov 'Stereotype', runner_context.call(:subject).class
            infov 'SCM', runner_context.call(:subject).scm
          end

          def show_test_commands
            return unless parsed.tests?

            infov 'Test commands', runner_context.call(:subject).test_commands.count
            runner_context.call(:subject).test_commands.each do |name, command|
              infov "  * #{name}", command
            end
          end

          def instance
            runner_context.call(:instance)
          end
        end
      end
    end
  end
end
