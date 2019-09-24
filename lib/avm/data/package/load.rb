# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'minitar'

module Avm
  module Data
    class Package
      class Load
        enable_console_speaker

        attr_reader :package, :data_file_path

        def initialize(package, data_file_path)
          @package = package
          @data_file_path = data_file_path
        end

        def runnable?
          cannot_run_reason.blank?
        end

        def cannot_run_reason
          return nil if data_file_exist?

          "Data file \"#{data_file_path}\" does not exist"
        end

        def run
          raise "Cannot run: #{cannot_run_reason}" unless runnable?

          build_dir = extract_packages_to_build_directory
          package.load_units_from_directory(build_dir)
        end

        def data_file_exist?
          ::File.exist?(data_file_path)
        end

        def extract_packages_to_build_directory
          dir = ::Dir.mktmpdir
          ::Minitar.unpack(data_file_path, dir)
          dir
        end
      end
    end
  end
end
