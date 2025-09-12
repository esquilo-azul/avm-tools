# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Issue
          class Deliver
            runner_with :confirmation, :help do
              desc 'Deliver a issue in a remote repository.'
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
              ::Avm::Sources::Issues::Deliver.new(runner_context.call(:subject).scm)
            end
          end
        end
      end
    end
  end
end
