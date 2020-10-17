# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Instance < ::EacRubyUtils::Console::DocoptRunner
        class Info < ::EacRubyUtils::Console::DocoptRunner
          runner_with

          runner_definition do
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
            infov 'Suffix', instance.suffix
          end

          def entry_keys_banner
            ::Avm::Instances::EntryKeys.all.each do |key|
              infov key, instance.read_entry_optional(key)
            end
          end

          def instance
            context(:instance)
          end
        end
      end
    end
  end
end
