# frozen_string_literal: true

require 'avm/data/clearer'
require 'eac_cli/core_ext'
require 'eac_cli/runner'

module Avm
  module Tools
    module RunnerWith
      module InstanceDataClear
        common_concern do
          enable_simple_cache
          include ::EacCli::Runner
        end

        def run
          performer.perform
        end

        private

        def performer_uncached
          %i[include exclude].inject(::Avm::Data::Clearer.new(data_owner)) do |a1, e1|
            if_respond(e1, []).inject(a1) { |a2, e2| a2.send(e1, e2) }
          end
        end
      end
    end
  end
end
