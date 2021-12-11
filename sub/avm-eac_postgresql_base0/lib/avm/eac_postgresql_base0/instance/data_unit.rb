# frozen_string_literal: true

require 'avm/data/instance/unit'

module Avm
  module EacPostgresqlBase0
    class Instance
      class DataUnit < ::Avm::Data::Instance::Unit
        EXTENSION = '.pgdump.gz'

        before_load :clear_database

        def dump_command
          instance.dump_gzip_command
        end

        def load_command
          instance.psql_command.prepend(['gzip', '-d', '@ESC_|'])
        end

        private

        def clear_database
          info 'Clearing database (Dropping all tables)...'
          run_sql(drop_all_tables_sql).if_present { |v| run_sql(v) }
        end

        def drop_all_tables_sql
          "select 'drop table \"' || tablename || '\" cascade;' from pg_tables " \
            "where schemaname = 'public';"
        end

        def run_sql(sql)
          instance.psql_command_command(sql).execute!
        end
      end
    end
  end
end
