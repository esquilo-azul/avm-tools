# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Launcher
        class Projects
          runner_with :help, ::Avm::Launcher::Instances::RunnerHelper do
            desc 'Shows available projects.'
            bool_opt '-i', '--instances', 'Show instances.'
          end

          def run
            ::Avm::Launcher::Context.current.projects.each do |p|
              show_project(p)
            end
          end

          private

          def show_project(project)
            puts project_label(project)
            return unless parsed.instances?

            project.instances.each do |i|
              puts "  * #{instance_label(i)}"
            end
          end

          def project_label(project)
            project.to_s.cyan.to_s
          end
        end
      end
    end
  end
end
