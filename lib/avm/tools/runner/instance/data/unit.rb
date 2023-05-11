# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Unit
            require_sub __FILE__
            runner_with :help, :subcommands do
              pos_arg :identifier
              subcommands
            end

            # @return [Enumerable<String>]
            def available_units_ids
              data_package.units_ids
            end

            # @return [Avm::Instances::Data::Package]
            def data_package
              runner_context.call(:instance).data_package
            end

            # @return [Avm::Instances::Data::Unit]
            def data_unit
              data_package.unit(parsed.identifier)
            end

            # @return [String]
            def help_extra_text
              help_join_sections(super, list_section('Available units', available_units_ids))
            end
          end
        end
      end
    end
  end
end
