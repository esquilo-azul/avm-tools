# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'avm/eac_rails_base1/runner/code_runner'

module Avm
  module Tools
    class Runner
      class EacRedmineBase0 < ::Avm::EacRailsBase1::Runner
        class ProjectRename
          runner_with ::Avm::EacRailsBase1::RunnerWith::Bundle do
            pos_arg :from
            pos_arg :to
          end

          def run
            bundle_run
          end

          def start_banner
            infov 'From', from
            infov 'To', to
          end

          delegate :from, :to, to: :parsed

          def bundle_args
            %w[exec rails runner] + [code]
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
