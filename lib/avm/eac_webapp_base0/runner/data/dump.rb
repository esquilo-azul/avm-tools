# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'
require 'avm/data/package/dump'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class Data < ::EacRubyUtils::Console::DocoptRunner
        class Dump < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::SimpleCache
          include ::EacRubyUtils::Console::Speaker

          DUMP_EXPIRE_TIME = 1.day
          DEFAULT_DUMP_PATH_ENTRY_SUFFIX = 'data.default_dump_path'
          NO_DUMP_MESSAGE = 'Dump "%s" already exist and rewrite options was no setted nor ' \
            'dump was expired.'

          DOC = <<~DOCUMENT
            Dump utility for EacRailsBase instance.

                Usage:
                __PROGRAM__ [options]

              Options:
                -h --help               Show this screen.
                --rewrite               Forces dump overwrite.
                --dump-path=<dump_path> Set DUMP_PATH variable.
          DOCUMENT

          def run
            infov 'Instance to dump', "#{context(:instance)} (#{context(:instance).class})"
            if package_dump.runnable?
              package_dump.run
            else
              warn(package_dump.cannot_run_reason)
            end
            success("Dump path: \"#{dump_path}\"")
            dump_path
          end

          private

          def package_dump_uncached
            context(:instance).data_package.dump(dump_path, existing: package_dump_existing)
          end

          def dump_path
            options.fetch('--dump-path') || default_dump_path
          end

          def default_dump_path
            context(:instance).read_entry(DEFAULT_DUMP_PATH_ENTRY_SUFFIX)
          end

          def package_dump_existing
            if options.fetch('--rewrite')
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
