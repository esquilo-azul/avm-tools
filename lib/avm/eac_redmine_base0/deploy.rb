# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/deploy'
require 'eac_ruby_utils/ruby'

module Avm
  module EacRedmineBase0
    class Deploy < ::Avm::Stereotypes::EacWebappBase0::Deploy
      set_callback :assert_instance_branch, :after, :run_installer

      def run_installer
        infom 'Running installer'
        ::EacRubyUtils::Ruby.on_clean_environment do
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
    end
  end
end
