# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/stereotypes/eac_ubuntu_base0/apache'
require 'avm/templates/file'
require 'avm/patches/object/template'

module Avm
  module Stereotypes
    module EacRailsBase0
      class ApacheHost
        enable_console_speaker
        enable_simple_cache
        common_constructor :instance

        def run
          write_available_no_ssl_site
          enable_no_ssl_site
          remove_ssl_site
          reload_apache
          run_certbot
          enable_ssl_site
          reload_apache
          ::Avm::Result.success('Done')
        end

        def no_ssl_site_content
          ::Avm::Templates::File.new(
            ::File.join(template_path, 'no_ssl.conf')
          ).apply(instance)
        end

        private

        def apache_uncached
          ::Avm::Stereotypes::EacUbuntuBase0::Apache.new(instance.host_env)
        end

        def enable_no_ssl_site
          infom 'Enabling no SSL site...'
          no_ssl_site.enable
        end

        def enable_ssl_site
          infom 'Enabling SSL site...'
          ssl_site.enable
        end

        def no_ssl_site_uncached
          apache.site(instance.id)
        end

        def reload_apache
          infom 'Reloading Apache...'
          apache.service('reload')
        end

        def remove_ssl_site
          infom 'Removing SSL site...'
          ssl_site.remove
        end

        def run_certbot
          infom 'Running Certbot...'
          instance.host_env.command(
            'sudo', 'certbot', '--apache', '--domain', instance.read_entry('web.hostname'),
            '--redirect', '--non-interactive', '--agree-tos',
            '--email', instance.read_entry('admin.email')
          ).system!
        end

        def ssl_site_uncached
          apache.site(no_ssl_site.name + '-le-ssl')
        end

        def write_available_no_ssl_site
          infom 'Writing no SSL site conf...'
          no_ssl_site.write(no_ssl_site_content)
        end
      end
    end
  end
end
