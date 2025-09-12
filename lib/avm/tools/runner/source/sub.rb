# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Sub
          runner_with :help, :subcommands do
            pos_arg :sub_path
            subcommands
          end
          for_context :source_sub

          private

          # !method source_sub
          # @return [Avm::Sources::Base::Sub]
          def source_sub_uncached
            source.sub(parsed.sub_path)
          end

          require_sub __FILE__
        end
      end
    end
  end
end
