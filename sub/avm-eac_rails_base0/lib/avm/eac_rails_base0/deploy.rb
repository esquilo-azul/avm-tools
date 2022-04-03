# frozen_string_literal: true

require 'eac_templates/core_ext'
require 'avm/eac_webapp_base0/deploy'
require 'avm/instances/entry_keys'

module Avm
  module EacRailsBase0
    class Deploy < ::Avm::EacWebappBase0::Deploy
      set_callback :assert_instance_branch, :after do
        bundle_install
        assert_database
        database_migrate
        compile_assets
        restart_tasks_scheduler
        touch_restart_file
      end

      def assert_database
        infom 'Asserting database...'
        instance.pg.assert
      end

      def bundle_install
        infom 'Running "bundle install"...'
        instance.bundle('install').system!
      end

      def compile_assets
        infom 'Compiling assets...'
        instance.rake('assets:clean', 'assets:precompile').system!
      end

      def database_migrate
        infom 'Running database migrations...'
        instance.rake('db:migrate').system!
      end

      def restart_tasks_scheduler
        infom 'Restarting Tasks Scheduler\'s daemon...'
        instance.bundle('exec', 'tasks_scheduler', 'restart').system!
      end

      def touch_restart_file
        infom 'Touching restart file...'
        instance.host_env.command(
          'touch', ::File.join(instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH),
                               'tmp', 'restart.txt')
        ).system!
      end
    end
  end
end
