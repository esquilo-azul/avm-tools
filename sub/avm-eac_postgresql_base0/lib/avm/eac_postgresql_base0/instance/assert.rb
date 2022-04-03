# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacPostgresqlBase0
    class Instance
      class Assert
        common_constructor :instance
        delegate :name, :password, :user, to: :instance

        def perform
          create_user unless user_exist?
          change_password unless password_ok?
          create_database unless database_exist?
          change_owner unless user_owner?
        end

        def change_owner
          root_execute("ALTER DaTABASE \"#{name}\" OWNER TO \"#{user}\"")
        end

        def change_password
          root_execute("ALTER USER \"#{user}\" WITH PASSWORD '#{password}'")
        end

        def create_user
          root_execute("CREATE USER \"#{user}\" WITH PASSWORD '#{password}'")
        end

        def current_owner
          root_query(<<~SQL
            SELECT pg_catalog.pg_get_userbyid(datdba)
            FROM pg_catalog.pg_database
            WHERE datname = '#{name}'
          SQL
                    )
        end

        def database_exist?
          root_boolean_query("FROM pg_database WHERE datname='#{name}'")
        end

        def password_ok?
          instance.psql_command_command('SELECT 1', false)
                  .execute!(exit_outputs: { 512 => 'login_failed' }).strip == '1'
        end

        def user_exist?
          root_boolean_query("FROM pg_roles WHERE rolname='#{user}'")
        end

        def user_owner?
          user == current_owner
        end

        def create_database
          root_execute("CREATE DATABASE \"#{name}\" WITH OWNER \"#{user}\"")
        end

        private

        def root_boolean_query(sql_after_projection)
          root_query("SELECT 1 #{sql_after_projection}") == '1'
        end

        def root_execute(sql)
          instance.root_psql_command(sql).execute!
        end

        def root_query(sql)
          root_execute(sql).strip
        end
      end
    end
  end
end
