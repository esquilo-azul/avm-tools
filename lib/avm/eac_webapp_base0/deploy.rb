# frozen_string_literal: true

require 'active_support/callbacks'
require 'avm/git'
require 'avm/patches/object/template'
require 'eac_ruby_utils/core_ext'
require 'eac_launcher/git/base'
require 'net/http'

module Avm
  module EacWebappBase0
    class Deploy
      require_sub __FILE__, include_modules: true
      include ::ActiveSupport::Callbacks

      DEFAULT_REFERENCE = 'HEAD'

      enable_console_speaker
      enable_simple_cache
      common_constructor :instance, :options, default: [{}]

      JOBS = %w[write_on_target setup_files_units assert_instance_branch request_test].freeze
      define_callbacks(*JOBS)

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
        infov 'Appended directories', appended_directories
      end

      def setup_files_units
        instance.class.const_get('FILES_UNITS').each do |data_key, fs_path_subpath|
          FileUnit.new(self, data_key, fs_path_subpath).run
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
    end
  end
end
