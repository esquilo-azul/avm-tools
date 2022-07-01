# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Testing
        TEST_COMMAND_KEY = 'test.command'

        def configured_test_command
          read_configuration_as_env_command(TEST_COMMAND_KEY)
        end

        # @return [Avm::Sources::Tester]
        def tester
          tester_class.new(self)
        end

        # @return [Class<Avm::Sources::Tester>
        def tester_class
          Avm::Sources::Tester
        end
      end
    end
  end
end
