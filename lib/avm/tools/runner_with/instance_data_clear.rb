# frozen_string_literal: true

require 'avm/data/clearer'
require 'eac_cli/core_ext'
require 'avm/tools/runner_with/instance_data_performer'

module Avm
  module Tools
    module RunnerWith
      module InstanceDataClear
        common_concern do
          enable_simple_cache
          include ::Avm::Tools::RunnerWith::InstanceDataPerformer
        end

        # @return [Class]
        def data_performer_class
          ::Avm::Data::Clearer
        end
      end
    end
  end
end
