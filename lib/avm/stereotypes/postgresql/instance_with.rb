# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/stereotypes/postgresql/instance'

module Avm
  module Stereotypes
    module Postgresql
      module InstanceWith
        def pg
          @pg ||= ::Avm::Stereotypes::Postgresql::Instance.new(
            host_env, user: read_entry(::Avm::Instances::EntryKeys::DATABASE_USERNAME),
                      password: read_entry(::Avm::Instances::EntryKeys::DATABASE_PASSWORD),
                      name: read_entry(::Avm::Instances::EntryKeys::DATABASE_NAME)
          )
        end
      end
    end
  end
end
