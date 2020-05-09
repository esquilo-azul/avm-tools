# frozen_string_literal: true

module Avm
  module Instances
    class Configuration < ::EacRubyUtils::Configs
      TEST_COMMAND_KEY = 'test.command'

      def test_command
        read_command(TEST_COMMAND_KEY)
      end
    end
  end
end
