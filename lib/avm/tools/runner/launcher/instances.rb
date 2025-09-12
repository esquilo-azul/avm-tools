# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Launcher
        class Instances
          runner_with :help, ::Avm::Launcher::Instances::RunnerHelper do
            desc 'Mostra informações sobre instâncias.'
            bool_opt '-e', '--extra', 'Show instances\' extra data.'
            pos_arg :instance_path, repeat: true, optional: true
          end

          def run
            instances.each { |i| show_instance(i) }
          end

          private

          def show_instance(instance)
            puts instance_label(instance)
            show_instance_extra(instance) if parsed.extra?
          end

          def show_instance_extra(instance)
            infov('  * Parent', (instance.parent ? instance_label(instance.parent) : '-'))
            infov('  * Git current revision', instance.options.git_current_revision)
            infov('  * Git publish remote', instance.options.git_publish_remote)
          end
        end
      end
    end
  end
end
