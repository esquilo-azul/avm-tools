# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacUbuntuBase0
    class Apache
      class Site
        common_constructor :apache, :name

        def available_path
          ::File.join(apache.etc_root, 'sites-available', "#{name}.conf")
        end

        def available?
          apache.host_env.file(available_path).exist?
        end

        def disable
          apache.host_env.command('sudo', 'a2dissite', name).execute!
        end

        def enable
          apache.host_env.command('sudo', 'a2ensite', name).execute!
        end

        def enabled_path
          ::File.join(apache.etc_root, 'sites-enabled', "#{name}.conf")
        end

        def enabled?
          apache.host_env.file(enabled_path).exist?
        end

        def remove
          remove_disabled
          remove_available
        end

        def remove_available
          raise 'Remove enabled before' if enabled?

          apache.host_env.command('sudo', 'rm', '-f', available_path).execute! if available?
        end

        def remove_disabled
          disable if enabled?
          apache.host_env.command('sudo', 'rm', '-f', enabled_path).execute! if enabled?
        end

        def write(content)
          ::EacRubyUtils::Envs.local.command('echo', content).pipe(
            apache.host_env.command('sudo', 'tee', available_path)
          ).execute!
        end
      end
    end
  end
end
