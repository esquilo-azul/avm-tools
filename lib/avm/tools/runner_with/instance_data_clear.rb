# frozen_string_literal: true

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
