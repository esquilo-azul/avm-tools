# frozen_string_literal: true

require 'avm/sources/tester'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    module Sources
      class Tester < ::Avm::Sources::Tester
        TEST_COMMAND_CONFIGURATION_KEY = :test_command

        enable_simple_cache

        # @return [EacRubyUtils::Envs::Command, nil]
        def test_command
          source.read_configuration_as_shell_words(TEST_COMMAND_CONFIGURATION_KEY)
                .if_present do |args|
            ::EacRubyUtils::Envs.local.command(args).chdir(source.path)
          end
        end

        # @return [EacFs::Logs]
        def logs
          @logs ||= ::EacFs::Logs.new.add(:stdout).add(:stderr)
        end

        # @return [Avm::Sources::Tests::Result]
        def result
          @result ||= begin
            if test_command.blank?
              ::Avm::Sources::Tests::Result::NONEXISTENT
            elsif run_test_command
              ::Avm::Sources::Tests::Result::SUCESSFUL
            else
              ::Avm::Sources::Tests::Result::FAILED
            end
          end
        end

        protected

        def run_test_command
          execute_command_and_log(test_command)
        end

        # @return [true, false]
        def execute_command_and_log(command)
          r = command.execute
          logs[:stdout].write(r[:stdout])
          logs[:stderr].write(r[:stderr])
          r[:exit_code].zero?
        end
      end
    end
  end
end
