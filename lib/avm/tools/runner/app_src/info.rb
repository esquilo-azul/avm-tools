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
            show_subs
          end

          private

          def show_instance
            infov 'Path', instance.path
            infov 'Stereotypes', instance.stereotypes.map(&:label).join(', ')
          end

          def show_source
            infov 'Stereotype', runner_context.call(:subject).stereotype
            infov 'SCM', runner_context.call(:subject).scm
          end

          def show_subs
            infov 'Sub applications', instance.avm_instance.subs.count
            instance.avm_instance.subs.each do |subapp|
              infov '  * ', subapp.relative_path
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
