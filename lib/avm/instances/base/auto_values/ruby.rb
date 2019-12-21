# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Ruby
          def auto_ruby_version
            inherited_entry_value(:host_id, 'ruby.version')
          end
        end
      end
    end
  end
end
