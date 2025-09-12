# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class AutoCommit
          runner_with :help do
            desc 'Auto fixup files.'
            bool_opt '-d', '--dirty', 'Select dirty files.'
            bool_opt '-f', '--format', 'Format files before commit.'
            arg_opt '-r', '--rule', 'Apply a rule in the specified order.', repeat: true
            pos_arg :files, repeat: true, optional: true
          end

          def run
            format_files
            files.each do |file|
              ::Avm::Sources::AutoCommit::ForFile.new(runner_context.call(:source), file, rules)
                .run
            end
          end

          def help_extra_text
            "Rules\n" + ::Avm::Scms::AutoCommit::Rules.all # rubocop:disable Style/StringConcatenation
                          .map { |r| "  #{r.keys.join(', ')}\n" }.join
          end

          private

          def files_uncached
            (files_from_option + dirty_files).sort.uniq
          end

          def files_from_option
            parsed.files.map { |p| p.to_pathname.expand_path }
          end

          def format_files
            return unless parsed.format?

            infom 'Formating files...'
            ::Avm::FileFormats::SearchFormatter
              .new(files, ::Avm::FileFormats::SearchFormatter::OPTION_APPLY => true)
              .run
          end

          def dirty_files
            return [] unless parsed.dirty?

            runner_context.call(:source).scm.changed_files.map(&:absolute_path)
          end

          def rules
            parsed.rule.map do |rule_string|
              ::Avm::Scms::AutoCommit::Rules.parse(rule_string)
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
