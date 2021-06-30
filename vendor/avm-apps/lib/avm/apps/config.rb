# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Apps
    class Config
      class << self
        # @deprecated Use EacConfig::Node.context instead.
        # @return [EacRubyUtils::Context<EacConfig::Node>]
        def context
          ::EacConfig::Node.context
        end

        delegate :current, to: :context
      end
    end
  end
end
