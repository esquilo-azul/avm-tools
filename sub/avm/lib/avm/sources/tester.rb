# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    module Tester
      TEST_COMMAND_CONFIGURATION_KEY = :test_command

      enable_simple_cache
      common_constructor :source_stereotype
      delegate :source, to: :source_stereotype

      # @return [EacRubyUtils::Envs::Command, nil]
      def test_command
        source.read_configuration_as_shell_words(TEST_COMMAND_CONFIGURATION_KEY)
              .if_present do |args|
          ::EacRubyUtils::Envs.local.command(args).chdir(source.path)
        end
      end

      private

      def logs_uncached
        ::EacRubyUtils::Fs::Logs.new.add(:stdout).add(:stderr)
      end

      # @return [Avm::Sources::Tests::Result]
      def result_uncached
        return ::Avm::Sources::Tests::Result::NONEXISTENT if test_command.blank?

        if execute_command_and_log(test_command)
          ::Avm::Sources::Tests::Result::SUCESSFUL
        else
          ::Avm::Sources::Tests::Result::FAILED
        end
      end

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
