# frozen_string_literal: true

require 'avm/eac_rails_base1/instance'

module Avm
  module EacRailsBase0
    class Instance < ::Avm::EacRailsBase1::Instance
      FILES_UNITS = { uploads: 'public/uploads' }.freeze
    end
  end
end
