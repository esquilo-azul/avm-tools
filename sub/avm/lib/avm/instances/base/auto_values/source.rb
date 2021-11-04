# frozen_string_literal: true

module Avm
  module Instances
    class Base
      module AutoValues
        module Source
          def auto_source_instance_id
            "#{application.id}_dev"
          end
        end
      end
    end
  end
end
