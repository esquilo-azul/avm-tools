# frozen_string_literal: true

module Avm
  module Tools
    module Rspec
      module Setup
        extend ::ActiveSupport::Concern

        SETUPS = %w[helpers].freeze

        def self.extended(setup_obj)
          SETUPS.each { |s| setup_obj.send("setup_#{s}") }
        end

        def setup_helpers
          rspec_config.include ::Avm::Tools::Rspec::Helpers::Runner
        end
      end
    end
  end
end
