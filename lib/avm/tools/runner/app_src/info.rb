# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Info
          runner_with :help do
            desc 'Show information about local project instance.'
          end

          def run
            show_instance
            show_source
          end

          private

          def show_instance
            infov 'Path', instance.path
            infov 'Launcher stereotypes', instance.stereotypes.map(&:label).join(', ')
          end

          def show_source
            infov 'Stereotype', runner_context.call(:subject).class
            infov 'SCM', runner_context.call(:subject).scm
          end

          def instance
            runner_context.call(:instance)
          end
        end
      end
    end
  end
end
