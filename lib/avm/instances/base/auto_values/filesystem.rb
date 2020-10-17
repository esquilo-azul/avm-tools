# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Filesystem
          FS_PATH_KEY = :fs_path

          def auto_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, FS_PATH_KEY) do |v|
              v + '/' + id
            end
          end

          def auto_data_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, :data_fs_path) do |v|
              v + '/' + id
            end
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
