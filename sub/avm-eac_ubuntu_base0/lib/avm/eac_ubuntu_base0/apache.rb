# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacUbuntuBase0
    class Apache
      require_sub __FILE__
      common_constructor :host_env

      def etc_root
        '/etc/apache2'
      end

      def service(command)
        host_env.command('sudo', 'service', 'apache2', command)
      end

      { conf: :conf, site: :sites }.each do |type, directory_prefix|
        define_method type do |name|
          ::Avm::EacUbuntuBase0::Apache::Resource.new(self, type, directory_prefix, name)
        end
      end
    end
  end
end
