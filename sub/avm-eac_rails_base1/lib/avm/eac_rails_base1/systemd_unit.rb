# frozen_string_literal: true

require 'avm/jobs/base'
require 'avm/eac_ubuntu_base0/apache'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    class SystemdUnit
      JOBS = %w[write_tasks_scheduler_command write_service link_service verify_service
                reload_systemd enable_service start_service].freeze

      include ::Avm::Jobs::Base
      require_sub __FILE__, include_modules: true
      delegate :platform_instance, to: :instance

      enable_listable
      lists.add_symbol :option, :exec_run, :restart

      def description
        "#{instance.id} Tasks Scheduler"
      end

      def exec_run?
        options[OPTION_EXEC_RUN]
      end

      def option_list
        self.class.lists.option
      end

      def restart
        options[OPTION_RESTART]
      end

      def unit_name
        "#{instance.id}_tasks_scheduler.service"
      end

      def user
        instance.ssh_username
      end

      private

      def sudo_execute!(*args)
        platform_instance.host_env.command(['sudo'] + args).execute!
      end

      def sudo_system!(*args)
        command_args = ['sudo'] + args
        infom "Running \"#{::Shellwords.join(command_args)}\"..."
        platform_instance.host_env.command(command_args).system!
      end
    end
  end
end
