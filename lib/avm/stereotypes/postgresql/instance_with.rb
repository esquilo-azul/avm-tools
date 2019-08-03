# frozen_string_literal: true

require 'avm/stereotypes/postgresql/instance'

module Avm
  module Stereotypes
    module Postgresql
      module InstanceWith
        def pg
          @pg ||= ::Avm::Stereotypes::Postgresql::Instance.new(
            host_env, user: read_entry('database.user'), password: read_entry('database.password'),
                      name: read_entry('database.name')
          )
        end
      end
    end
  end
end
