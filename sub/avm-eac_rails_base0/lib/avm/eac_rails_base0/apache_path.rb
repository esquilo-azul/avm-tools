# frozen_string_literal: true

require 'avm/eac_webapp_base0/apache_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase0
    class ApachePath < ::Avm::EacWebappBase0::ApachePath
      def document_root
        ::File.join(super, 'public')
      end

      def extra_content
        template.child('extra_content.conf').apply(instance)
      end
    end
  end
end
