# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/instance'
require 'avm/stereotypes/rails/instance'

module Avm
  module Stereotypes
    module EacRailsBase0
      class Instance < ::Avm::Stereotypes::EacWebappBase0::Instance
        include ::Avm::Stereotypes::Rails::Instance

        FILES_UNITS = { uploads: 'public/uploads' }.freeze
      end
    end
  end
end
