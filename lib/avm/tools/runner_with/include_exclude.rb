# frozen_string_literal: true

module Avm
  module Tools
    module RunnerWith
      module IncludeExclude
        common_concern do
          include ::EacCli::Runner

          runner_definition do
            arg_opt '-I', '--include', repeat: true
            arg_opt '-E', '--exclude', repeat: true
          end
        end

        delegate :include, :exclude, to: :parsed
      end
    end
  end
end
