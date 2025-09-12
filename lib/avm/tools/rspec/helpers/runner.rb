# frozen_string_literal: true

module Avm
  module Tools
    module Rspec
      module Helpers
        module Runner
          def avm_tools_runner_args_prefix
            []
          end

          def avm_tools_runner_run(*argv)
            Avm::Tools::Runner.run(argv: avm_tools_runner_args_prefix + argv)
          end
        end
      end
    end
  end
end
