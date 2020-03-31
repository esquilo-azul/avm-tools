# frozen_string_literal: true

require 'eac_ruby_utils/envs'

module Avm
  module Executables
    class << self
      def env
        ::EacRubyUtils::Envs.local
      end

      def file
        @file ||= env.executable('file', '--version')
      end

      def git
        @git ||= env.executable('git', '--version')
      end

      def docker
        @docker ||= env.executable('docker', '--version')
      end

      def php_cs_fixer
        @php_cs_fixer ||= env.executable('php-cs-fixer', '--version')
      end
    end
  end
end
