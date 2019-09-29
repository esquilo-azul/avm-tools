# frozen_string_literal: true

require 'eac_ruby_utils/envs'

module Avm
  module Executables
    class << self
      def env
        ::EacRubyUtils::Envs.local
      end

      def git
        @git ||= env.executable('git', '--version')
      end
    end
  end
end
