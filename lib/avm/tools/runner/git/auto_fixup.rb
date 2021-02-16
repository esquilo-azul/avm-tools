# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'avm/git/file_auto_fixup'
require 'avm/git/auto_commit/rules'

module Avm
  module Tools
    class Runner
      class Git
        class AutoFixup
          runner_with :help do
            desc 'Auto fixup files.'
            bool_opt '-d', '--dirty', 'Select dirty files.'
            arg_opt '-r', '--rule', 'Apply a rule in the specified order.', repeat: true
            pos_arg :files, repeat: true, optional: true
          end

          def run
            files.each do |file|
              ::Avm::Git::FileAutoFixup.new(runner_context.call(:git), file, rules).run
            end
          end

          private

          def files
            (files_from_option + dirty_files).sort.uniq
          end

          def files_from_option
            parsed.files.map { |p| p.to_pathname.expand_path }
          end

          def dirty_files
            return [] unless parsed.dirty?

            runner_context.call(:git).dirty_files.map do |file|
              file.path.to_pathname.expand_path(runner_context.call(:git).root_path)
            end
          end

          def rules
            parsed.rule.map do |rule_string|
              ::Avm::Git::AutoCommit::Rules.parse(rule_string)
            end
          end

          def select
            parsed.last? ? 1 : parsed.select
          end
        end
      end
    end
  end
end
