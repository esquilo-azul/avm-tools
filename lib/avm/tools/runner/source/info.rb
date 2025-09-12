# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Info
          SOURCE_PROPERTIES = {
            path: 'Path',
            application: 'Application',
            class: 'Stereotype',
            scm: 'SCM'
          }.freeze

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
            SOURCE_PROPERTIES.each do |property, label|
              infov label, runner_context.call(:subject).send(property)
            end
          end

          def show_test_commands
            return unless parsed.tests?

            infov 'Test commands', runner_context.call(:subject).test_commands.count
            runner_context.call(:subject).test_commands.each do |name, command|
              infov "  * #{name}", command
            end
          end
        end
      end
    end
  end
end
