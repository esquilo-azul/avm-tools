# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'

module Avm
  module Stereotypes
    module EacWebappBase0
      module Runner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          class Load < ::EacRubyUtils::Console::DocoptRunner
            include ::EacRubyUtils::SimpleCache
            include ::EacRubyUtils::Console::Speaker

            DOC = <<~DOCUMENT
              Load utility for EacRailsBase instance.

              Usage:
                __PROGRAM__ (<dump-path>|--source-instance=<source-instance>)
                __PROGRAM__ -h | --help

              Options:
                -h --help                               Show this screen.
                -S --source-instance=<source-instance>  Informa a instância a ser extraída o dump.
            DOCUMENT

            def run
              return ::Dev::Result.error("Dump \"#{dump_path}\" does not exist") unless
              ::File.exist?(dump_path)

              load_dump
              success("Dump loaded from \"#{dump_path}\"")
            end

            def dump_path_uncached
              return options.fetch('<dump-path>').to_s if options.fetch('<dump-path>').present?
              return source_instance_dump_path if options.fetch('--source-instance').present?

              raise "Dump path unknown (Options: #{options})"
            end

            def source_instance_dump_path
              context(:instance).class.by_id(
                options.fetch('--source-instance')
              ).data_dump
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
              context(:instance).data_package.load(dump_path)
            end
          end
        end
      end
    end
  end
end
