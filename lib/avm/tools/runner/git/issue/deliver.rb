# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/sources/issues/deliver'

module Avm
  module Tools
    class Runner
      class Git
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
              ::Avm::Sources::Issues::Deliver.new(runner_context.call(:git_repo))
            end
          end
        end
      end
    end
  end
end
