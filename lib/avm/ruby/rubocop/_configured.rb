# frozen_string_literal: true

require 'avm/apps/sources/configuration'

module Avm
  module Ruby
    class Rubocop
      def configured_rubocop_command_uncached
        configured_rubocop_command_by_command || configured_rubocop_command_by_gemfile
      end

      def configured_rubocop_command_by_command
        configuration.if_present(&:rubocop_command)
      end

      def configured_rubocop_command_by_gemfile
        configuration.if_present(&:rubocop_gemfile).if_present do |v|
          rubocop_command_by_gemfile_path(v.parent)
        end
      end

      private

      def configuration_uncached
        ::Avm::Apps::Sources::Configuration.find_by_path(base_path)
      end
    end
  end
end
