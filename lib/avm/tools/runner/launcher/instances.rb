# frozen_string_literal: true

require 'eac_launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Launcher < ::EacLauncher::Runner
        class Instances < ::EacLauncher::Instances::RunnerHelper
          DOC = <<~DOCOPT
            Mostra informações sobre instâncias.

            Usage:
              __PROGRAM__ [options] [<instance_path>...]
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
              --all            Get all instances.
              --recache        Rewrite instances cache.

          DOCOPT

          def run
            ::EacLauncher::Context.current.recache = options['--recache']
            instances.each { |i| show_instance(i) }
          end

          private

          def show_instance(instance)
            puts instance_label(instance)
            infov('  * Parent', (instance.parent ? instance_label(instance.parent) : '-'))
            infov('  * Git current revision', instance.options.git_current_revision)
            infov('  * Git publish remote', instance.options.git_publish_remote)
          end

          def instance_path
            options['<instance_path>']
          end
        end
      end
    end
  end
end
