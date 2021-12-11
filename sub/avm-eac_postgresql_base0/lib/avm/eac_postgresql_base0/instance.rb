# frozen_string_literal: true

require 'avm/eac_postgresql_base0/instance/data_unit'

module Avm
  module EacPostgresqlBase0
    class Instance
      def initialize(env, connection_params)
        @env = env
        @connection_params = connection_params.with_indifferent_access
      end

      def data_unit
        ::Avm::EacPostgresqlBase0::Instance::DataUnit.new(self)
      end

      def dump_command
        env.command('pg_dump', '--no-privileges', '--clean', '--no-owner', *common_command_args)
           .envvar('PGPASSWORD', password)
      end

      def dump_gzip_command
        dump_command.append(['@ESC_|', 'gzip', '-9', '-c'])
      end

      def psql_command
        env.command("@ESC_PGPASSWORD=#{password}", 'psql', *common_command_args)
      end

      def psql_command_command(sql)
        psql_command.append(['--quiet', '--tuples-only', '--command', sql])
      end

      private

      attr_reader :env, :connection_params

      def common_command_args
        ['--host', host, '--username', user, '--port', port, name]
      end

      def host
        connection_params[:host] || '127.0.0.1'
      end

      def port
        connection_params[:port] || '5432'
      end

      def user
        connection_params.fetch(:user)
      end

      def password
        connection_params.fetch(:password)
      end

      def name
        connection_params.fetch(:name)
      end
    end
  end
end
