# frozen_string_literal: true

require 'eac_ruby_base0/application'
require 'eac_ruby_utils'
require 'avm/instances/base'

module Avm
  module Tools
    module Self
      ::EacRubyUtils.require_sub(__FILE__)

      class << self
        def application
          @application ||= ::EacRubyBase0::Application.new(root.to_path)
        end

        def root
          ::Pathname.new('../../..').expand_path(__dir__)
        end
      end
    end
  end
end
