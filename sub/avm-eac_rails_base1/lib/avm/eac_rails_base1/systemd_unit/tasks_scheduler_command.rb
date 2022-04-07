# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    class SystemdUnit
      module TasksSchedulerCommand
        def tasks_scheduler_command_content
          template.child('tasks_scheduler_command.sh').apply(variables_source)
        end

        def tasks_scheduler_command_path
          "/opt/aux/#{instance.id}/tasks_scheduler.sh"
        end

        private

        def write_tasks_scheduler_command
          infom 'Writing tasks scheduler\'s command...'
          sudo_execute!('mkdir', '-p', ::File.dirname(tasks_scheduler_command_path))
          platform_instance.file_sudo_write(tasks_scheduler_command_path,
                                            tasks_scheduler_command_content)
          sudo_execute!('chmod', '+x', tasks_scheduler_command_path)
        end
      end
    end
  end
end
