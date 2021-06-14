# frozen_string_literal: true

require 'avm/core_ext'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner
      class Git
        class Issue
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Issue operations within Git.'
            bool_opt '--deliver', 'Run "deliver" task.'
            subcommands
          end

          def run
            run_deliver if parsed.deliver?
            success('Done!')
          end

          def run_deliver
            deliver.start_banner
            return deliver.run if confirm?('Confirm issue delivery?')

            uncomplete_message('Issue was not delivered')
          end

          private

          def deliver_uncached
            ::Avm::Git::Issue::Deliver.new(runner_context.call(:git_repo))
          end
        end
      end
    end
  end
end
