# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/git/issue/deliver'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Issue
          class Deliver
            runner_with :confirmation, :help do
              desc 'Deliver a issue in a Git repository.'
            end

            def run
              deliver.start_banner
              if confirm?('Confirm issue delivery?')
                deliver.run
              else
                fatal_error 'Issue undelivered'
              end
            end

            private

            def deliver_uncached
              ::Avm::Git::Issue::Deliver.new(runner_context.call(:subject).scm.git_repo)
            end
          end
        end
      end
    end
  end
end
