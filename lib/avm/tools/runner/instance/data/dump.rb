# frozen_string_literal: true

require 'avm/data/package/dump'
require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Dump
            DUMP_EXPIRE_TIME = 1.day
            NO_DUMP_MESSAGE = 'Dump "%s" already exist and rewrite options was no setted nor ' \
              'dump was expired.'

            runner_with :help do
              desc 'Dump utility for EacRailsBase instance.'
              bool_opt '-w', '--rewrite', 'Forces dump overwrite.'
              pos_arg :dump_path
            end

            # @return [String]
            def help_extra_text
              "Default dump path: \"#{default_dump_path}\""
            end

            def run
              infov 'Instance to dump', "#{instance} (#{instance.class})"
              if package_dump.runnable?
                package_dump.run
              else
                warn(package_dump.cannot_run_reason)
              end
              success("Dump path: \"#{dump_path}\"")
              dump_path
            end

            private

            def instance
              runner_context.call(:instance)
            end

            def package_dump_uncached
              instance
                .data_package.dump(dump_path, existing: package_dump_existing)
            end

            def dump_path
              parsed.dump_path || default_dump_path
            end

            def default_dump_path
              instance.data_default_dump_path
            end

            def package_dump_existing
              if parsed.rewrite?
                ::Avm::Data::Package::Dump::EXISTING_ROTATE
              else
                ::Avm::Data::Package::Dump::EXISTING_ROTATE_EXPIRED
              end
            end
          end
        end
      end
    end
  end
end
