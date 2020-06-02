# frozen_string_literal: true

require 'avm/instances/configuration'
require 'avm/result'
require 'eac_ruby_utils/fs/temp'

module Avm
  module Git
    module Issue
      class Complete
        def test_result
          test_command = configuration.if_present(&:test_command)
          return ::Avm::Result.success('unconfigured') unless test_command.present?

          infom "Running test command \"#{test_command}\"..."
          result = test_command.execute
          test_result_log(result)
          if result.fetch(:exit_code).zero?
            ::Avm::Result.success('yes')
          else
            ::Avm::Result.error('no')
          end
        end

        private

        def test_result_log(result)
          stdout_file = ::EacRubyUtils::Fs::Temp.file
          stderr_file = ::EacRubyUtils::Fs::Temp.file
          stdout_file.write(result.fetch(:stdout))
          stderr_file.write(result.fetch(:stderr))
          infov '  * Exit code', result.fetch(:exit_code)
          infov '  * STDOUT', stdout_file.to_path
          infov '  * STDERR', stderr_file.to_path
        end

        def configuration_uncached
          ::Avm::Instances::Configuration.find_by_path(@git)
        end
      end
    end
  end
end
