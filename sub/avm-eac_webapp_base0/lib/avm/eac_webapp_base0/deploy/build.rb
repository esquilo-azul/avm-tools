# frozen_string_literal: true

require 'avm/files/appender'
require 'avm/files/deploy'
require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/fs/temp'

module Avm
  module EacWebappBase0
    class Deploy
      module Build
        private

        attr_accessor :build_dir

        def append_instance_content
          ::Avm::Files::Appender
            .new
            .variables_source_set(variables_source)
            .append_templatized_directory(template.path)
            .append_templatized_directories(appended_directories)
            .append_file_content(version_target_path, version)
            .write_appended_on(build_dir)
        end

        def build_dir_env
          ::EacRubyUtils::Envs.local
        end

        def create_build_dir
          self.build_dir = ::EacRubyUtils::Fs::Temp.directory
        end

        def remove_build_dir
          build_dir&.remove
        end

        def build_content
          infom 'Writing Git source code...'
          ::Avm::Git::Commit.new(git, commit_sha1).deploy_to_env_path(
            build_dir_env,
            build_dir
          ).variables_source_set(variables_source).run
        end
      end
    end
  end
end
