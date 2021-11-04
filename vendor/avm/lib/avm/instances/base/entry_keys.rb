# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module EntryKeys
        ::Avm::Instances::EntryKeys.all.each do |key|
          method_name = key.to_s.variableize
          define_method method_name do
            read_entry(key)
          end

          define_method "#{method_name}_optional" do
            read_entry(key, required: false)
          end
        end
      end
    end
  end
end
