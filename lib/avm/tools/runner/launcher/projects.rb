# frozen_string_literal: true

require 'eac_launcher/context'
require 'eac_launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Launcher < ::EacRubyUtils::Console::DocoptRunner
        class Projects < ::EacLauncher::Instances::RunnerHelper
          DOC = <<~DOCOPT
            Shows available projects.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help        Show this screen.
              -i --instances   Show instances.
              --recache        Rewrite instances cache.

          DOCOPT

          def run
            ::EacLauncher::Context.current.recache = options['--recache']
            ::EacLauncher::Context.current.projects.each do |p|
              show_project(p)
            end
          end

          private

          def show_project(project)
            puts project_label(project)
            return unless options['--instances']

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
