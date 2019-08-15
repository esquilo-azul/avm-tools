# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Data < ::EacRubyUtils::Console::DocoptRunner
          class Load < ::EacRubyUtils::Console::DocoptRunner
            include ::EacRubyUtils::SimpleCache
            include ::EacRubyUtils::Console::Speaker

            DOC = <<~DOCUMENT
              Load utility for EacRailsBase instance.

              Usage:
                __PROGRAM__ <dump-path>
                __PROGRAM__ -h | --help

              Options:
                -h --help               Show this screen.
            DOCUMENT

            def run
              return ::Dev::Result.error("Dump \"#{dump_path}\" does not exist") unless
              ::File.exist?(dump_path)

              before_load
              load_dump
              fix_web_addresses
              success("Dump loaded from \"#{dump_path}\"")
            end

            def dump_path_uncached
              options.fetch('<dump-path>').to_s
            end

            def load_dump
              info "Loading dump \"#{dump_path}\"..."
              ::EacRubyUtils::Envs.local.command('cat', dump_path).pipe(load_command).execute!
            end

            def dump_instance_method
              :dump_database
            end

            def before_load
              info 'Clearing database (Dropping all tables)...'
              sql = run_sql(drop_all_tables_sql)
              run_sql(sql) if sql.present?
            end

            def drop_all_tables_sql
              "select 'drop table \"' || tablename || '\" cascade;' from pg_tables " \
                "where schemaname = 'public';"
            end

            def run_sql(sql)
              context(:instance).pg.psql_command_command(sql).execute!
            end

            def load_command
              context(:instance).pg.psql_command.prepend(['gzip', '-d', '@ESC_|'])
            end

            def fix_web_addresses
              info 'Fixing web addresses...'
              run_sql(<<~SQL)
                update wp_options
                set option_value = '#{context(:instance).read_entry('url')}'
                where option_name in ('siteurl', 'home')
              SQL
            end
          end
        end
      end
    end
  end
end
