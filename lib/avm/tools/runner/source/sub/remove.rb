# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Sub
          class Remove
            runner_with :help

            def run
              source_sub.remove
              success "Sub[#{source_sub.sub_path}] removed"
            end
          end
        end
      end
    end
  end
end
