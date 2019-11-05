# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/deploy'

module Avm
  module Stereotypes
    module EacRailsBase0
      class Deploy < ::Avm::Stereotypes::EacWebappBase0::Deploy
        set_callback :assert_instance_branch, :after do
          bundle_install
        end

        def bundle_install
          infom 'Running "bundle install"...'
          instance.bundle('install').system!
        end
      end
    end
  end
end
