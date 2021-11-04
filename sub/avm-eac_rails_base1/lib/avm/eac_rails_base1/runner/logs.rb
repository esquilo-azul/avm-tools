# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner'
require 'eac_cli/core_ext'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Logs
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Manipule multiple application\'s logs.'
          subcommands
        end
      end
    end
  end
end
