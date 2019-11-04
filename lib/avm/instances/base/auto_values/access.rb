# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Access
          def auto_access
            read_entry_optional('ssh.url').present? ? 'ssh' : 'local'
          end

          def auto_ssh_hostname
            inherited_entry_value(:host_id, 'ssh.hostname')
          end

          def auto_ssh_port
            inherited_entry_value(:host_id, 'ssh.port') || 22
          end

          def auto_ssh_username
            inherited_entry_value(:host_id, 'ssh.username')
          end

          def auto_ssh_url
            inherited_entry_value(:host_id, 'ssh.url') || auto_ssh_url_by_parts
          end

          def auto_ssh_url_by_parts
            read_entry_optional('ssh.hostname').if_present do |a|
              a = read_entry_optional('ssh.username').if_present(a) { |v| "#{v}@#{a}" }
              a = read_entry_optional('ssh.port').if_present(a) { |v| "#{a}:#{v}" }
              "ssh://#{a}"
            end
          end
        end
      end
    end
  end
end
