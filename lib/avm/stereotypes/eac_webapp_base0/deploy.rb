# frozen_string_literal: true

require 'active_support/callbacks'
require 'delegate'
require 'eac_ruby_utils/core_ext'
require 'eac_launcher/git/base'
require 'avm/git'
require 'avm/patches/object/template'
require 'net/http'

module Avm
  module Stereotypes
    module EacWebappBase0
      class Deploy
        include ::ActiveSupport::Callbacks

        DEFAULT_REFERENCE = 'HEAD'

        enable_console_speaker
        enable_simple_cache

        JOBS = %w[git_deploy setup_files_units assert_instance_branch request_test].freeze
        define_callbacks(*JOBS)

        attr_reader :instance, :options

        def initialize(instance, options = {})
          @instance = instance
          @options = options
        end

        def run
          start_banner
          JOBS.each do |job|
            run_callbacks job do
              send(job)
            end
          end
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
          ).append_directory(template.path).variables_source_set(instance).run
        end

        def git_reference
          options[:reference] || DEFAULT_REFERENCE
        end

        def setup_files_units
          instance.class.const_get('FILES_UNITS').each do |data_key, fs_path_subpath|
            FilesUnit.new(self, data_key, fs_path_subpath).run
          end
        end

        def assert_instance_branch
          infom 'Setting instance branch...'
          git.execute!('push', git_remote_name, "#{commit_sha1}:refs/heads/#{instance.id}", '-f')
        end

        def request_test
          infom 'Requesting web interface...'
          uri = URI(instance.read_entry('web.url'))
          response = ::Net::HTTP.get_response(uri)
          infov 'Response status', response.code
          fatal_error "Request to #{uri} failed" unless response.code.to_i == 200
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
      end
    end
  end
end
