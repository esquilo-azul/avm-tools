# frozen_string_literal: true

require 'delegate'
require 'eac_ruby_utils/core_ext'
require 'eac_launcher/git/base'
require 'avm/git'
require 'avm/patches/object/template'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Deploy
        enable_console_speaker
        enable_simple_cache

        attr_reader :instance, :git_reference

        def initialize(instance, git_reference)
          @instance = instance
          @git_reference = git_reference
        end

        def run
          start_banner
          git_deploy
          setup_files_units
          assert_instance_branch
          ::Avm::Result.success('Deployed')
        rescue ::Avm::Result::Error => e
          e.to_result
        end

        def start_banner
          infov 'Instance', instance
          infov 'Git reference (User)', git_reference.if_present('- BLANK -')
          infov 'Git remote name', git_remote_name
          infov 'Git reference (Found)', git_reference_found
          infov 'Git commit SHA1', commit_sha1
        end

        def git_deploy
          infom 'Deploying source code and appended content...'
          ::Avm::Git::Commit.new(git, commit_sha1).deploy_to_env_path(
            instance.host_env,
            instance.read_entry(:fs_path)
          ).append_directory(template_path).variables_source_set(instance).run
        end

        def setup_files_units
          ::Avm::Stereotypes::EacWordpressBase0::Instance::FILES_UNITS
            .each do |data_key, fs_path_subpath|
            FilesUnit.new(self, data_key, fs_path_subpath).run
          end
        end

        def assert_instance_branch
          infom 'Setting instance branch...'
          git.execute!('push', git_remote_name, "#{commit_sha1}:refs/heads/#{instance.id}", '-f')
        end

        def commit_sha1_uncached
          git_fetch
          r = git.rev_parse(git_reference_found)
          return r if r

          raise ::Avm::Result::Error, "No commit SHA1 found for \"#{git_reference_found}\""
        end

        def git_reference_found_uncached
          %w[git_reference instance_branch master_branch].map { |b| send(b) }.find(&:present?) ||
            raise(
              ::Avm::Result::Error,
              'No git reference found (Searched for option, instance and master)'
            )
        end

        def git_uncached
          ::EacLauncher::Git::Base.new(git_repository_path)
        end

        def instance_branch
          remote_branch(instance.id)
        end

        def master_branch
          remote_branch('master')
        end

        def git_remote_name
          ::Avm::Git::DEFAULT_REMOTE_NAME
        end

        def git_remote_hashs_uncached
          git.remote_hashs(git_remote_name)
        end

        def git_fetch_uncached
          infom "Fetching remote \"#{git_remote_name}\" from \"#{git_repository_path}\"..."
          git.fetch(git_remote_name)
        end

        def git_repository_path
          instance.source_instance.read_entry(:fs_path)
        end

        def remote_branch(name)
          git_remote_hashs.key?("refs/heads/#{name}") ? "#{git_remote_name}/#{name}" : nil
        end

        class FilesUnit < ::SimpleDelegator
          attr_reader :data_key, :fs_path_subpath

          def initialize(deploy, data_key, fs_path_subpath)
            super(deploy)
            @data_key = data_key
            @fs_path_subpath = fs_path_subpath
          end

          def run
            assert_source_directory
            link_source_target
          end

          def assert_source_directory
            infom "Asserting \"#{data_key}\" source directory..."
            instance.host_env.command('mkdir', '-p', source_path).execute!
          end

          def source_path
            ::File.join(instance.read_entry(:data_fs_path), data_key.to_s)
          end

          def target_path
            ::File.join(instance.read_entry(:fs_path), fs_path_subpath.to_s)
          end

          def link_source_target
            infom "Linking \"#{data_key}\" directory..."
            instance.host_env.command('rm', '-rf', target_path).execute!
            instance.host_env.command('ln', '-s', source_path, target_path).execute!
          end
        end
      end
    end
  end
end
