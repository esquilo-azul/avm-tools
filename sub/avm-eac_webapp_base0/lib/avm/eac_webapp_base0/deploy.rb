# frozen_string_literal: true

require 'active_support/callbacks'
require 'avm/jobs/base'
require 'avm/git'
require 'eac_ruby_utils/core_ext'
require 'eac_templates/core_ext'
require 'avm/launcher/git/base'
require 'net/http'

module Avm
  module EacWebappBase0
    class Deploy
      require_sub __FILE__, include_modules: true

      DEFAULT_REFERENCE = 'HEAD'

      REQUEST_TEST_JOB = 'request_test'
      JOBS = (%w[create_build_dir build_content append_instance_content write_on_target
                 setup_files_units assert_instance_branch] + [REQUEST_TEST_JOB]).freeze

      include ::Avm::Jobs::Base

      lists.add_symbol :option, :appended_directories, :no_request_test, :reference

      def option_list
        ::Avm::EacWebappBase0::Deploy.lists.option
      end

      def run
        super
      ensure
        remove_build_dir
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

      protected

      def jobs
        r = super
        r.delete(REQUEST_TEST_JOB) if options[OPTION_NO_REQUEST_TEST]
        r
      end
    end
  end
end
