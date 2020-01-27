# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Database
          DEFAULT_HOSTNAME = '127.0.0.1'
          DEFAULT_PORTS = {
            'postgresql' => 5432,
            'mysql' => 3306,
            'oracle' => 1521,
            'sqlserver' => 1433
          }.freeze
          DEFAULT_SYSTEM = 'postgresql'

          def auto_database_name
            inherited_entry_value(::Avm::Instances::EntryKeys::DATABASE_ID,
                                  ::Avm::Instances::EntryKeys::DATABASE_NAME) || id
          end

          def auto_database_hostname
            database_auto_common('hostname') || DEFAULT_HOSTNAME
          end

          def auto_database_password
            database_auto_common('password')
          end

          def auto_database_port
            database_auto_common('port') || database_port_by_system
          end

          def auto_database_username
            database_auto_common('username')
          end

          def auto_database_system
            database_auto_common('system') || DEFAULT_SYSTEM
          end

          private

          def database_auto_common(suffix)
            database_key = ::Avm::Instances::EntryKeys.const_get("database_#{suffix}".upcase)
            inherited_entry_value(::Avm::Instances::EntryKeys::DATABASE_ID, database_key) ||
              inherited_entry_value(:host_id, database_key)
          end

          def database_port_by_system
            read_entry_optional(::Avm::Instances::EntryKeys::DATABASE_SYSTEM).if_present do |v|
              DEFAULT_PORTS.fetch(v)
            end
          end
        end
      end
    end
  end
end
