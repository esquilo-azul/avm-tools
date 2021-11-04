# frozen_string_literal: true

require 'avm/jobs/base'
require 'avm/eac_ubuntu_base0/apache'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    class ApachePath
      JOBS = %w[write_available_conf enable_conf reload_apache].freeze
      include ::Avm::Jobs::Base

      def content
        ::Avm::EacWebappBase0::ApachePath.template.child('default.conf').apply(variables_source)
      end

      def document_root
        instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
      end

      def extra_content
        ''
      end

      private

      def apache_uncached
        ::Avm::EacUbuntuBase0::Apache.new(instance.host_env)
      end

      def enable_conf
        infom 'Enabling configuration...'
        conf.enable
      end

      def reload_apache
        infom 'Reloading Apache...'
        apache.service('reload')
      end

      def conf_uncached
        apache.conf(instance.id)
      end

      def write_available_conf
        infom 'Writing available configuration...'
        conf.write(content)
      end
    end
  end
end
