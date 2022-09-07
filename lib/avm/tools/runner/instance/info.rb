# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Info
          runner_with :help do
            desc 'Show info about a instance.'
          end

          def run
            base_banner
            entry_keys_banner
          end

          private

          def base_banner
            infov 'ID', instance.id
            infov 'Application ID', instance.application.id
            infov 'Application stereotype', instance.application.stereotype
            infov 'Suffix', instance.suffix
          end

          def entry_keys_banner
            ::Avm::Instances::EntryKeys.all.each do |key|
              infov key, instance.read_entry_optional(key)
            end
          end

          def instance
            runner_context.call(:instance)
          end
        end
      end
    end
  end
end
