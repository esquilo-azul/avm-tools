# frozen_string_literal: true

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
