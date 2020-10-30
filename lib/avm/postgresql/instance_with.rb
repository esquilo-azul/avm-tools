# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/postgresql/instance'

module Avm
  module Postgresql
    module InstanceWith
      def pg
        @pg ||= ::Avm::Postgresql::Instance.new(
          host_env, user: read_entry(::Avm::Instances::EntryKeys::DATABASE_USERNAME),
                    password: read_entry(::Avm::Instances::EntryKeys::DATABASE_PASSWORD),
                    name: read_entry(::Avm::Instances::EntryKeys::DATABASE_NAME)
        )
      end
    end
  end
end
