# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/bundle'
require 'avm/instances/entry_keys'
require 'eac_cli/core_ext'
require 'shellwords'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class RailsServer
        DEFAULT_RAILS_ENVIRONMENT = 'development'
        runner_with :help, ::Avm::EacRailsBase1::RunnerWith::Bundle do
          desc 'Run the embbeded Rails web server.'
        end

        def run
          infov 'Environment', rails_environment
          infov 'Bundle args', ::Shellwords.join(bundle_args)
          infov 'Result', bundle_command.system
        end

        protected

        def bundle_args
          ['exec', 'rails', 'server', '--port',
           runner_context.call(:instance).read_entry(::Avm::Instances::EntryKeys::WEB_PORT)]
        end
      end
    end
  end
end
