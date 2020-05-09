# frozen_string_literal: true

module Avm
  module Instances
    class Configuration < ::EacRubyUtils::Configs
      RUBOCOP_COMMAND_KEY = 'ruby.rubocop.command'

      def rubocop_command
        read_command(RUBOCOP_COMMAND_KEY)
      end
    end
  end
end
