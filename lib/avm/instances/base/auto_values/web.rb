# frozen_string_literal: true

require 'addressable'

module Avm
  module Instances
    class Base
      module AutoValues
        module Web
          def auto_web_authority
            web_url_as_uri(&:authority)
          end

          def auto_web_hostname
            web_url_as_uri(&:host)
          end

          def auto_web_path
            web_url_as_uri(&:path)
          end

          def auto_web_port
            web_url_as_uri(&:port)
          end

          def auto_web_scheme
            web_url_as_uri(&:scheme)
          end

          def auto_web_userinfo
            web_url_as_uri(&:userinfo)
          end

          private

          def web_url_as_uri
            read_entry_optional('web.url').if_present do |v|
              yield(::Addressable::URI.parse(v))
            end
          end
        end
      end
    end
  end
end
