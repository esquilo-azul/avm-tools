# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Filesystem
          def auto_fs_path
            inherited_entry_value(:host_id, :fs_path) { |v| v + '/' + id }
          end

          def auto_data_fs_path
            inherited_entry_value(:host_id, :data_fs_path) { |v| v + '/' + id }
          end
        end
      end
    end
  end
end
