# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/bundle'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'shellwords'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Bundle < ::EacRubyUtils::Console::DocoptRunner
        runner_with ::Avm::EacRailsBase1::RunnerWith::Bundle
        runner_definition do
          desc 'Runs "bundle ...".'
          pos_arg :'bundle-args', repeat: true, optional: true
        end

        def run
          bundle_run
        end

        def bundle_args
          options.fetch('<bundle-args>').reject { |arg| arg == '--' }
        end
      end
    end
  end
end
