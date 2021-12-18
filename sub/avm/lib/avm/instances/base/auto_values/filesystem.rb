# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Filesystem
          def auto_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID,
                                  ::Avm::Instances::EntryKeys::FS_PATH) { |v| v + '/' + id }
          end

          def auto_data_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID, :data_fs_path) do |v|
              v + '/' + id
            end
          end

          def auto_fs_url
            auto_fs_url_with_ssh || auto_fs_url_without_ssh
          end

          def auto_fs_url_with_ssh
            read_entry_optional('ssh.url').if_present do |ssh_url|
              read_entry_optional('fs_path').if_present do |fs_path|
                "#{ssh_url}#{fs_path}"
              end
            end
          end

          def auto_fs_url_without_ssh
            return nil if read_entry_optional('ssh.url').present?

            read_entry_optional('fs_path').if_present do |fs_path|
              "file://#{fs_path}"
            end
          end
        end
      end
    end
  end
end
