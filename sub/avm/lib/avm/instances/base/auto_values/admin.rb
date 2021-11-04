# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Admin
          def auto_admin_email
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, 'admin.email')
          end

          def auto_admin_name
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, 'admin.name')
          end
        end
      end
    end
  end
end
