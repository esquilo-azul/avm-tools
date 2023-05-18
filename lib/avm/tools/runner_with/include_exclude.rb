# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/runner'

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
