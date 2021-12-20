# frozen_string_literal: true

require 'avm/eac_rails_base0/instance'
require 'avm/eac_rails_base0/deploy'
require 'avm/eac_rails_base0/apache_host'
require 'avm/eac_rails_base0/apache_path'
require 'avm/eac_rails_base1/runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase0
    module Runners
      class Base < ::Avm::EacRailsBase1::Runner
        require_sub __FILE__

        STEREOTYPE_NAME = 'EacRailsBase0'

        class << self
          def stereotype_name
            STEREOTYPE_NAME
          end
        end
      end
    end
  end
end
