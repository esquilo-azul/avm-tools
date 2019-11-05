# frozen_string_literal: true

require 'addressable'

module Avm
  module Instances
    class Base
      module AutoValues
        module Web
          def auto_web_hostname
            read_entry_optional('web.url').if_present do |v|
              ::Addressable::URI.parse(v).host
            end
          end
        end
      end
    end
  end
end
