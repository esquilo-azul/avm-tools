# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/projects/stereotypes'

module Avm
  module Tools
    class Runner
      class Launcher
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Utilities to deploy applications and libraries.'
          subcommands
        end
      end
    end
  end
end
