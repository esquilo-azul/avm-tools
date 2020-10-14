# frozen_string_literal: true

require 'avm/eac_webapp_base0/instance'
require 'avm/rails/instance'

module Avm
  module EacRailsBase0
    class Instance < ::Avm::EacWebappBase0::Instance
      include ::Avm::Rails::Instance

      FILES_UNITS = { uploads: 'public/uploads' }.freeze
    end
  end
end
