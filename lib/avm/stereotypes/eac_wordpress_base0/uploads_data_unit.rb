# frozen_string_literal: true

require 'minitar'
require 'zlib'
require 'avm/data/instance/unit'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Instance < ::Avm::Instances::Base
        class UploadsDataUnit < ::Avm::Data::Instance::Unit
          EXTENSION = '.tar.gz'

          before_load :clear_uploads

          def uploads_path
            ::File.join(instance.read_entry(:fs_path), 'wp-content', 'uploads')
          end

          def dump_command
            instance.host_env.command('tar', '-czf', '-', '-C', uploads_path, '.')
          end

          def load_command
            instance.host_env.command('tar', '-xzf', '-', '-C', uploads_path)
          end

          def clear_uploads
            infom "Removing all files under #{uploads_path}..."
            instance.host_env.command('find', uploads_path, '-mindepth', 1, '-delete').execute!
          end
        end
      end
    end
  end
end
