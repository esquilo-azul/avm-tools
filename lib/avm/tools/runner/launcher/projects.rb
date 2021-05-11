# frozen_string_literal: true

require 'eac_launcher/context'
require 'avm/launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner
      class Launcher
        class Projects < ::Avm::Launcher::Instances::RunnerHelper
          runner_with :help do
            desc 'Shows available projects.'
            bool_opt '--recache', 'Rewrite instances cache.'
            bool_opt '-i', '--instances', 'Show instances.'
          end

          def run
            ::EacLauncher::Context.current.recache = parsed.recache?
            ::EacLauncher::Context.current.projects.each do |p|
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
