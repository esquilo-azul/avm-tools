# frozen_string_literal: true

require 'avm/data/instance/unit'

module Avm
  module Data
    module Instance
      class FilesUnit < ::Avm::Data::Instance::Unit
        EXTENSION = '.tar.gz'

        attr_reader :fs_path_subpath

        def initialize(instance, fs_path_subpath)
          super(instance)
          @fs_path_subpath = fs_path_subpath
        end

        before_load :clear_files

        def files_path
          ::File.join(instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH), fs_path_subpath)
        end

        def dump_command
          instance.host_env.command('tar', '-czf', '-', '-C', files_path, '.')
        end

        def load_command
          instance.host_env.command('tar', '-xzf', '-', '-C', files_path)
        end

        def clear_files
          infom "Removing all files under #{files_path}..."
          instance.host_env.command('find', files_path, '-mindepth', 1, '-delete').execute!
        end
      end
    end
  end
end
