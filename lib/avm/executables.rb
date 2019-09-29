# frozen_string_literal: true

require 'eac_ruby_utils/envs'

module Avm
  module Executables
    class << self
      def env
        ::EacRubyUtils::Envs.local
      end
    end
  end
end
