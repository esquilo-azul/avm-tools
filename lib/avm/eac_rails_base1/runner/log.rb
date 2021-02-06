# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/rails_environment'
require 'avm/eac_webapp_base0/runner'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Log
        runner_with :help, ::Avm::EacRailsBase1::RunnerWith::RailsEnvironment do
          desc 'Read application\'s log.'
          bool_opt '-f', '--follow', 'Output appended data as the log grows.'
        end

        def run
          start_banner
          tail_command.system
        end

        private

        def log_path
          ::File.join(rails_instance.read_entry('fs_path'), 'log', "#{rails_environment}.log")
        end

        def start_banner
          infov 'Environment', rails_environment
          infov 'Log path', log_path
        end

        def tail_command
          rails_instance.host_env.command(*tail_command_args)
        end

        def tail_command_args
          r = %w[tail]
          r << '--follow' if parsed.follow?
          r + [log_path]
        end
      end
    end
  end
end
