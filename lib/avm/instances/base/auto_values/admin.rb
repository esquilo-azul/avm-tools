# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Admin
          def auto_admin_email
            inherited_entry_value(:host_id, 'admin.email')
          end

          def auto_admin_name
            inherited_entry_value(:host_id, 'admin.name')
          end
        end
      end
    end
  end
end
