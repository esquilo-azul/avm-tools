# frozen_string_literal: true

require 'avm/eac_webapp_base0/apache_host'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class ApacheHost < ::Avm::EacWebappBase0::ApacheHost
        def document_root
          instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
        end

        def extra_content
          "AssignUserID #{system_user} #{system_group}"
        end

        def system_user
          instance.read_entry('system.username')
        end

        def system_group
          instance.read_entry('system.groupname')
        end
      end
    end
  end
end
