# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Apps
    class Config
      enable_context

      class << self
        delegate :current, to: :context
      end
    end
  end
end
