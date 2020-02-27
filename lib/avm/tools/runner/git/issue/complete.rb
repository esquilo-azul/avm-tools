# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Issue < ::EacRubyUtils::Console::DocoptRunner
          class Complete < ::EacRubyUtils::Console::DocoptRunner
            include ::EacRubyUtils::Console::Speaker

            DOC = <<~DOCOPT
              Closes a issue in a Git repository.

              Usage:
                __PROGRAM__ [options]
                __PROGRAM__ -h | --help

              Options:
                -h --help                             Show this screen.
                -s --skip-validations=<validations>   Does not validate conditions on <validations>
                                                      (Comma separated value).
                -y --yes                              Does not ask for user confirmation.

              Validations:
              %%VALIDATIONS%%
            DOCOPT

            def run
              complete = ::Avm::Git::Issue::Complete.new(git_complete_issue_options)
              complete.start_banner
              fatal_error('Some validation did not pass') unless complete.valid?
              complete.run if confirm?
            end

            def doc
              DOC.gsub('%%VALIDATIONS%%', doc_validations_list)
            end

            private

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
          end
        end
      end
    end
  end
end
