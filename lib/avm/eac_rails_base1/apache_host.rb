# frozen_string_literal: true

require 'avm/eac_webapp_base0/apache_host'

module Avm
  module EacRailsBase1
    class ApacheHost < ::Avm::EacWebappBase0::ApacheHost
      def document_root
        "#{instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)}/public"
      end

      def extra_content
        'PassengerEnabled On'
      end
    end
  end
end
