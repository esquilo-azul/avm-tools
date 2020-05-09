# frozen_string_literal: true

require 'avm/instances/configuration'
require 'avm/result'

module Avm
  module Git
    module Issue
      class Complete
        def test_result
          test_command = configuration.if_present(&:test_command)
          return ::Avm::Result.success('unconfigured') unless test_command.present?

          if test_command.execute[:exit_code].zero?
            ::Avm::Result.success('yes')
          else
            ::Avm::Result.error('no')
          end
        end

        private

        def configuration_uncached
          ::Avm::Instances::Configuration.find_by_path(@git)
        end
      end
    end
  end
end
