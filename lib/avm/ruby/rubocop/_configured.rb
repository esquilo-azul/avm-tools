# frozen_string_literal: true

require 'avm/instances/configuration'

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
        gemfile_path = configuration.if_present { |v| v.read_entry('ruby.rubocop.gemfile') }
        return nil unless gemfile_path.present?

        gemfile_path = ::Pathname.new(gemfile_path).expand_path(configuration.storage_path.parent)
        raise "Gemfile path \"#{gemfile_path}\" does not exist" unless gemfile_path.exist?

        rubocop_command_by_gemfile_path(gemfile_path.parent)
      end

      private

      def configuration_uncached
        ::Avm::Instances::Configuration.find_by_path(base_path)
      end
    end
  end
end
