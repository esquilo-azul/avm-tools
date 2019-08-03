# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          class Dump < ::EacRubyUtils::Console::DocoptRunner
            include ::EacRubyUtils::SimpleCache
            include ::EacRubyUtils::Console::Speaker

            DUMP_EXPIRE_TIME = 1.days
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
              if run_dump?
                run_dump
              else
                warn(format(NO_DUMP_MESSAGE, dump_path))
              end
              success("Dump path: \"#{dump_path}\"")
            end

            private

            def dump_path
              options.fetch('--dump-path') || default_dump_path
            end

            def default_dump_path
              context(:instance).read_entry(DEFAULT_DUMP_PATH_ENTRY_SUFFIX)
            end

            def dump_exist?
              ::File.exist?(dump_path)
            end

            def dump_time_uncached
              dump_exist? ? ::Time.now - ::File.mtime(dump_path) : nil
            end

            def dump_expired?
              return false unless dump_time.present?

              dump_time >= DUMP_EXPIRE_TIME
            end

            def run_dump
              download_dump
              rotate_dump
              move_download_to_final_dest
            end

            def download_dump
              infom 'Downloading dump...'
              dump_command.system!(output_file: download_path)
              fatal_error "File \"#{download_path}\" not saved" unless ::File.exist?(download_path)
              fatal_error "File \"#{download_path}\" is empty" if ::File.zero?(download_path)
            end

            def move_download_to_final_dest
              ::FileUtils.mv(download_path, dump_path)
            end

            def rotate_dump
              return unless dump_exist?

              info "Rotating \"#{dump_path}\"..."
              ::Avm::Files::Rotate.new(dump_path).run
            end

            def download_path_uncached
              f = ::Tempfile.new('eac_rails_base0_data_dump')
              path = f.path
              f.close
              f.unlink
              path
            end

            def run_dump?
              !dump_exist? || options.fetch('--rewrite') || dump_expired?
            end

            def dump_command
              context(:instance).pg.dump_gzip_command
            end
          end
        end
      end
    end
  end
end
