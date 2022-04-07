# frozen_string_literal: true

require 'avm/eac_rails_base1/systemd_unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class TasksScheduler
        class SystemdUnit
          DEFAULT_RESTART = 'on-failure'

          runner_with :help do
            desc 'Configure Systemd unit for instace\'s tasks scheduler daemon (Reference: ' \
              'https://www.freedesktop.org/software/systemd/man/systemd.service.html).'
            bool_opt '-e', '--exec-run', 'Run daemon with "run" instead of "start"/"stop".'
            arg_opt '-r', '--restart', 'Value for systemd.service, Restart=.',
                    default: DEFAULT_RESTART
          end

          delegate :restart, to: :parsed

          def run
            if result.error?
              fatal_error result.to_s
            else
              infov 'Result', result.label
            end
          end

          private

          def systemd_unit_uncached
            ::Avm::EacRailsBase1::SystemdUnit.new(runner_context.call(:instance),
                                                  restart: parsed.restart,
                                                  exec_run: parsed.exec_run?)
          end

          def result_uncached
            systemd_unit.run
          end
        end
      end
    end
  end
end
