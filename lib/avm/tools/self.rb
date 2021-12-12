# frozen_string_literal: true

require 'eac_ruby_base0/application'
require 'eac_ruby_utils/require_sub'
require 'avm/instances/base'

module Avm
  module Tools
    module Self
      ::EacRubyUtils.require_sub(__FILE__)

      class << self
        def application
          @application ||= ::EacRubyBase0::Application.new(root.to_path)
        end

        def instance
          @instance ||= ::Avm::Tools::Self::Instance.by_id('avm-tools_self')
        end

        def root
          ::Pathname.new('../../..').expand_path(__dir__)
        end
      end
    end
  end
end
