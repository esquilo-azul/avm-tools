# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/eac_postgresql_base0/instance'

module Avm
  module EacPostgresqlBase0
    module InstanceWith
      def pg
        @pg ||= ::Avm::EacPostgresqlBase0::Instance.new(
          host_env, user: read_entry(::Avm::Instances::EntryKeys::DATABASE_USERNAME),
                    password: read_entry(::Avm::Instances::EntryKeys::DATABASE_PASSWORD),
                    name: read_entry(::Avm::Instances::EntryKeys::DATABASE_NAME)
        )
      end
    end
  end
end
