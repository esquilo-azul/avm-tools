# frozen_string_literal: true

require 'avm/eac_rails_base1/runner_with/bundle'
require 'eac_cli/core_ext'
require 'shellwords'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Bundle
        runner_with ::Avm::EacRailsBase1::RunnerWith::Bundle, :help do
          desc 'Runs "bundle ...".'
          pos_arg :'bundle-args', repeat: true, optional: true
        end

        def run
          bundle_run
        end

        def bundle_args
          parsed.bundle_args.reject { |arg| arg == '--' }
        end
      end
    end
  end
end
