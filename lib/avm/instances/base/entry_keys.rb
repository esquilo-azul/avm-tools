# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module EntryKeys
        ::Avm::Instances::EntryKeys.all.each do |key|
          define_method key.to_s.variableize do
            read_entry(key)
          end
        end
      end
    end
  end
end
