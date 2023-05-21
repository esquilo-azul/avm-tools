# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/runner'

module Avm
  module Tools
    module RunnerWith
      module InstanceDataPerformer
        acts_as_abstract :data_performer_class
        common_concern do
          enable_simple_cache
          include ::EacCli::Runner
        end

        def run
          if data_performer.performable?
            data_performer.perform
          else
            warn("Cannot perform: #{data_performer.cannot_perform_reason}")
          end
        end

        private

        # @return [Avm::Data::Performer]
        def data_performer_uncached
          %i[include exclude].inject(data_performer_class.new(data_owner)) do |a1, e1|
            if_respond(e1, []).inject(a1) { |a2, e2| a2.send(e1, e2) }
          end
        end
      end
    end
  end
end
