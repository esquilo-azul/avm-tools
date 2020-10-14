# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'shellwords'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::EacRubyUtils::Console::DocoptRunner
        class RailsServer
          runner_with

          runner_definition do
            desc 'Run the embbeded Rails web server.'
            arg_opt '-e', '--environment', 'Specifies the environment to run this server under' \
              ' (development/test/production).'
          end

          def run
            infov 'Bundle args', ::Shellwords.join(bundle_args)
            infov 'Result', command.system
          end

          protected

          def bundle_args
            ['exec', 'rails', 'server', '--port',
             runner_context.call(:instance).read_entry(::Avm::Instances::EntryKeys::WEB_PORT)] +
              parsed.environment.if_present([]) { |v| ['--environment', v] }
          end

          def command
            runner_context.call(:instance).bundle(*bundle_args).chdir_root
          end
        end
      end
    end
  end
end
