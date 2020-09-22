# frozen_string_literal: true

require 'avm/rails/runners/runner'
require 'eac_cli/default_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        class ProjectRename < ::Avm::Rails::Runners::Runner
          include ::EacCli::DefaultRunner

          runner_definition do
            pos_arg :from
            pos_arg :to
          end

          def run
            start_banner
            command.system!
          end

          def start_banner
            infov 'From', from
            infov 'To', to
          end

          def from
            options.fetch('<from>')
          end

          def to
            options.fetch('<to>')
          end

          def command
            context(:instance).bundle('exec', 'rails', 'runner', code)
          end

          def code
            <<~CODE
              from_arg = '#{from}'
              to_arg = '#{to}'
              project = ::Project.where(identifier: from_arg).first
              if project.present?
                puts "Project found: \#{project}"
                puts "Renaming..."
                project.update_column(:identifier, to_arg)
                puts "Renamed. Testing..."
                project = ::Project.where(identifier: to_arg).first
                if project
                  puts "Project found: \#{project}"
                else
                  fail "After rename: project not found with identifier \\"\#{to_arg}\\""
                end
              else
                fail "Before rename: project not found with identifier \\"\#{from_arg}\\""
              end
            CODE
          end
        end
      end
    end
  end
end
