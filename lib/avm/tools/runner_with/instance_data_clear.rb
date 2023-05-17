# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/runner'

module Avm
  module Tools
    module RunnerWith
      module InstanceDataClear
        common_concern do
          include ::EacCli::Runner
        end

        def run
          data_owner.clear
        end
      end
    end
  end
end
