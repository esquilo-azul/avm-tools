# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    module Rspec
      module Setup
        extend ::ActiveSupport::Concern

        SETUPS = %w[].freeze

        def self.extended(setup_obj)
          SETUPS.each { |s| setup_obj.send("setup_#{s}") }
        end
      end
    end
  end
end
