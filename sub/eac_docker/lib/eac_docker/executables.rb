# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module EacDocker
  module Executables
    class << self
      def env
        ::EacRubyUtils::Envs.local
      end

      def docker
        @docker ||= env.executable('docker', '--version')
      end
    end
  end
end
