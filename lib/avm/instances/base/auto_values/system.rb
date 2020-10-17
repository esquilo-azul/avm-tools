# frozen_string_literal: true

require 'addressable'

module Avm
  module Instances
    class Base
      module AutoValues
        module System
          def auto_system_username
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, 'system.username') ||
              read_entry_optional('ssh.username')
          end

          def auto_system_groupname
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, 'system.groupname') ||
              read_entry_optional('system.username')
          end
        end
      end
    end
  end
end
