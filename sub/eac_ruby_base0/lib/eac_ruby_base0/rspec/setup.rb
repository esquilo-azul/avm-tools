# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyBase0
  module Rspec
    module Setup
      def self.extended(obj)
        obj.disable_input_request
        obj.stub_eac_config_node
      end
    end
  end
end
