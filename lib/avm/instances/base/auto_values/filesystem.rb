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

          def auto_fs_url
            read_entry_optional('ssh.url').if_present do |ssh_url|
              read_entry_optional('fs_path').if_present do |fs_path|
                "#{ssh_url}#{fs_path}"
              end
            end
          end
        end
      end
    end
  end
end
