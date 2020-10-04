# frozen_string_literal: true

require 'avm/eac_ubuntu_base0/apache'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase0
    class ApachePath
      enable_console_speaker
      enable_simple_cache
      common_constructor :instance, :options, default: [{}]

      def run
        write_available_conf
        enable_conf
        reload_apache
        ::Avm::Result.success('Done')
      end

      def content
        template.child('default.conf').apply(instance)
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
