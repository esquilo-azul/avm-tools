# frozen_string_literal: true

require 'addressable'

module Avm
  module Instances
    class Base
      module AutoValues
        module Web
          def auto_web_hostname
            web_url_as_uri(&:host)
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
