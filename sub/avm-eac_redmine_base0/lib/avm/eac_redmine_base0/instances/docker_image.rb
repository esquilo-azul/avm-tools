# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/instances/docker_image'
require 'avm/eac_redmine_base0/patches/object/template'

module Avm
  module EacRedmineBase0
    module Instances
      class DockerImage < ::Avm::Instances::DockerImage
        enable_simple_cache

        INSTALLER_TARGET_TASK = 'redmine_as_apache_base'
        DATABASE_INTERNAL_HOSTNAME = 'localhost'
        REDMINE_SOURCE_HOST_SUBPATH = 'redmine_source'

        def avm_fs_cache_object_id
          instance.id
        end

        def database_internal
          instance.entry(::Avm::Instances::EntryKeys::DATABASE_HOSTNAME).value ==
            DATABASE_INTERNAL_HOSTNAME
        end

        def installer_target_task
          INSTALLER_TARGET_TASK
        end

        def redmine_user
          'redmine'
        end

        def redmine_user_home
          "/home/#{redmine_user}"
        end

        def redmine_path
          "#{redmine_user_home}/redmine_app"
        end

        def skip_database
          ENV['SKIP_DATABASE']
        end

        def start_path
          '/start.sh'
        end

        private

        def git_repo_uncached
          ::EacGit::Local.new(instance.source_instance.fs_path)
        end

        def redmine_source_git_id
          git_repo.rev_parse('HEAD')
        end

        def redmine_source_path_uncached
          r = provide_dir.join(REDMINE_SOURCE_HOST_SUBPATH)
          ::FileUtils.rm_rf(r.to_path)
          r.mkpath
          git_repo.commit(redmine_source_git_id).archive_to_dir(r).system!
          REDMINE_SOURCE_HOST_SUBPATH
        end
      end
    end
  end
end
