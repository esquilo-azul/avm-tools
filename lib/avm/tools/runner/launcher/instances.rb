# frozen_string_literal: true

require 'avm/launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner
      class Launcher
        class Instances < ::Avm::Launcher::Instances::RunnerHelper
          runner_with :help do
            desc 'Mostra informações sobre instâncias.'
            bool_opt '--recache', 'Rewrite instances cache.'
            bool_opt '--all', 'Get all instances.'
            pos_arg :instance_path, repeat: true, optional: true
          end

          def run
            ::Avm::Launcher::Context.current.recache = parsed.recache?
            instances.each { |i| show_instance(i) }
          end

          private

          def show_instance(instance)
            puts instance_label(instance)
            infov('  * Parent', (instance.parent ? instance_label(instance.parent) : '-'))
            infov('  * Git current revision', instance.options.git_current_revision)
            infov('  * Git publish remote', instance.options.git_publish_remote)
          end
        end
      end
    end
  end
end
