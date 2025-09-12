# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Files
        class Format
          runner_with :help do
            desc 'Format files.'
            bool_opt '-a', '--apply', 'Confirm changes.'
            bool_opt '-n', '--no-recursive', 'No recursive.'
            bool_opt '-q', '--quiet', 'Do not output messages.'
            bool_opt '-d', '--dirty', 'Select modified files to format.'
            pos_arg :paths, repeat: true, optional: true
          end

          def run
            ::Avm::FileFormats::SearchFormatter.new(source_paths, formatter_options).run
          end

          def formatter_options
            { ::Avm::FileFormats::SearchFormatter::OPTION_APPLY => parsed.apply?,
              ::Avm::FileFormats::SearchFormatter::OPTION_RECURSIVE => !parsed.no_recursive?,
              ::Avm::FileFormats::SearchFormatter::OPTION_VERBOSE => !parsed.quiet? }
          end

          def scm
            @scm ||= ::Avm::Registry.scms.detect('.')
          end

          def dirty_files
            scm.changed_files.map(&:absolute_path).select(&:exist?).map(&:to_path)
          end

          def source_paths
            if parsed.dirty?
              parsed.paths + dirty_files
            else
              parsed.paths.if_present(%w[.])
            end
          end
        end
      end
    end
  end
end
