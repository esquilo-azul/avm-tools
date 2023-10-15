# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Issue
          class Complete
            runner_with :confirmation, :help do
              desc 'Closes a issue in a Git repository.'
              bool_opt '-f', '--uncomplete-unfail', 'Do not exit with error if issue is not ' \
                'completed or is invalid.'
              arg_opt '-s', '--skip-validations', 'Does not validate conditions on <validations> ' \
                '(Comma separated value).'
            end

            def run
              return unless run_validate
              return unless run_complete

              success('Done!')
            end

            def help_extra_text
              "Validations:\n#{doc_validations_list}"
            end

            def run_validate
              complete.start_banner
              return true if complete.valid?

              uncomplete_message('Some validation did not pass')
            end

            def run_complete
              return complete.run if confirm?('Confirm issue completion?')

              uncomplete_message('Issue was not completed')
            end

            private

            def complete_uncached
              ::Avm::Git::Issue::Complete.new(git_complete_issue_options)
            end

            def skip_validations
              parsed.skip_validations.to_s.split(',').map(&:strip).reject(&:blank?)
            end

            def git_complete_issue_options
              { dir: runner_context.call(:subject).path.to_path,
                skip_validations: skip_validations }
            end

            def doc_validations_list
              ::Avm::Git::Issue::Complete::VALIDATIONS.keys.map { |k| "  * #{k}" }.join("\n")
            end

            def uncomplete_unfail?
              parsed.uncomplete_unfail?
            end

            def uncomplete_message(message)
              if uncomplete_unfail?
                warn(message)
              else
                fatal_error(message)
              end
              false
            end
          end
        end
      end
    end
  end
end
