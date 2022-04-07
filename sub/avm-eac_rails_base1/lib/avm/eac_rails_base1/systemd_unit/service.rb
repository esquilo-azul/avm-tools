# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    class SystemdUnit
      module Service
        def service_content
          template.child('tasks_scheduler.service').apply(variables_source)
        end

        def service_exec_lines
          service_exec_operations
            .map { |k, v| "#{k}=#{tasks_scheduler_command_path} #{v}" }
            .join("\n")
        end

        def service_path
          ::Pathname.new('/etc/systemd/system').join(unit_name)
        end

        def service_link_path
          ::Pathname.new('/etc/systemd/system/multi-user.target.wants').join(unit_name)
        end

        def verify_service
          sudo_system!('systemd-analyze', 'verify', service_path)
        end

        private

        def enable_service
          systemctl('enable', unit_name)
        end

        def link_service
          sudo_execute!('rm', '-f', service_link_path)
          sudo_execute!('ln', '-s', service_path, service_link_path)
        end

        def reload_systemd
          systemctl('daemon-reload')
        end

        # @return [Hash<String, String>]
        def service_exec_operations
          if exec_run?
            { 'ExecStart' => 'run' }
          else
            { 'ExecStart' => 'start', 'ExecStop' => 'stop' }
          end
        end

        def start_service
          systemctl('start', unit_name)
        end

        def systemctl(*args)
          sudo_system!('systemctl', *args)
        end

        def write_service
          infom 'Writing service\'s unit file...'
          platform_instance.file_sudo_write(service_path, service_content)
        end
      end
    end
  end
end
