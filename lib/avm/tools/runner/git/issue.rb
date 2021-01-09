# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner
      class Git
        class Issue < ::EacRubyUtils::Console::DocoptRunner
          enable_simple_cache
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Closes a issue in a Git repository.

            Usage:
              __PROGRAM__ [options] [complete]
              __PROGRAM__ -h | --help

            Options:
              -h --help                             Show this screen.
              -f --uncomplete-unfail                Do not exit with error if issue is not completed
                                                    or is invalid.
              -s --skip-validations=<validations>   Does not validate conditions on <validations>
                                                    (Comma separated value).
              -y --yes                              Does not ask for user confirmation.

            Validations:
            %%VALIDATIONS%%
          DOCOPT

          UNCOMPLETE_MESSAGE =

            def run
              banner
              return unless validate

              run_complete if options.fetch('complete')
              success('Done!')
            end

          def banner
            complete.start_banner
          end

          def validate
            return true if complete.valid?

            uncomplete_message('Some validation did not pass')
          end

          def run_complete
            return complete.run if confirm?

            uncomplete_message('Issue was not completed')
          end

          def doc
            DOC.gsub('%%VALIDATIONS%%', doc_validations_list)
          end

          private

          def complete_uncached
            ::Avm::Git::Issue::Complete.new(git_complete_issue_options)
          end

          def confirm?
            options.fetch('--yes') || request_input('Confirm issue completion?', bool: true)
          end

          def skip_validations
            options.fetch('--skip-validations').to_s.split(',').map(&:strip).reject(&:blank?)
          end

          def git_complete_issue_options
            { dir: context(:repository_path), skip_validations: skip_validations }
          end

          def doc_validations_list
            ::Avm::Git::Issue::Complete::VALIDATIONS.keys.map { |k| "  * #{k}" }.join("\n")
          end

          def uncomplete_unfail?
            options.fetch('--uncomplete-unfail')
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
