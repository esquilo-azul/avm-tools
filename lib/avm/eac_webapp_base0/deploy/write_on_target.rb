# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    class Deploy
      module WriteOnTarget
        def write_on_target
          git_deploy
        end

        private

        def build_git_commit
          ::Avm::Git::Commit.new(git, commit_sha1).deploy_to_env_path(
            instance.host_env,
            instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
          ).variables_source_set(instance)
        end

        def git_deploy
          infom 'Deploying source code and appended content...'
          build_git_commit
            .append_templatized_directory(template.path)
            .append_templatized_directories(appended_directories)
            .append_file_content(VERSION_TARGET_PATH, version)
            .run
        end
      end
    end
  end
end
