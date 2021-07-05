# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'eac_cli/speaker'
require 'eac_ruby_utils/simple_cache'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class Data
        class Load
          runner_with :help do
            desc 'Load utility for EacRailsBase instance.'
            arg_opt '-S', '--source-instance', 'Informa a instância a ser extraída o dump.'
            pos_arg :dump_path, optional: true
          end

          def run
            return ::Dev::Result.error("Dump \"#{dump_path}\" does not exist") unless
            ::File.exist?(dump_path)

            load_dump
            success("Dump loaded from \"#{dump_path}\"")
          end

          def dump_path_uncached
            return parsed.dump_path.to_s if parsed.dump_path.present?
            return source_instance_dump_path if parsed.source_instance.present?

            raise "Dump path unknown (Options: #{parsed})"
          end

          def source_instance_dump_path
            runner_context.call(:instance).class.by_id(parsed.source_instance).data_dump
          end

          def load_dump
            info "Loading dump \"#{dump_path}\"..."
            package_load.run
          end

          def dump_instance_method
            :dump_database
          end

          private

          def package_load_uncached
            runner_context.call(:instance).data_package.load(dump_path)
          end
        end
      end
    end
  end
end
