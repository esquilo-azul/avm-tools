# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/deploy'

module Avm
  module Stereotypes
    module EacRedmineBase0
      class Deploy < ::Avm::Stereotypes::EacWebappBase0::Deploy
        set_callback :assert_instance_branch, :after, :run_installer

        def run_installer
          infom 'Running installer'
          on_clean_ruby do
            installer_command.system!
          end
        end

        def installer_command
          instance.host_env.command(installer_path, install_task)
        end

        def installer_path
          ::File.join(instance.read_entry(:fs_path), 'plugins', 'redmine_installer', 'installer',
                      'run.sh')
        end

        def install_task
          if instance.read_entry_optional('web.path').present?
            'redmine_as_apache_path'
          else
            'redmine_as_apache_base'
          end
        end

        def on_clean_ruby
          on_clear_envvars('BUNDLE', 'RUBY') { yield }
        end

        private

        def on_clear_envvars(*start_with_vars)
          old_values = envvars_starting_with(start_with_vars)
          old_values.keys.each { |k| ENV.delete(k) }
          yield
        ensure
          old_values&.each { |k, v| ENV[k] = v }
        end

        def envvars_starting_with(start_with_vars)
          ENV.select { |k, _v| start_with_vars.any? { |var| k.start_with?(var) } }
        end
      end
    end
  end
end
