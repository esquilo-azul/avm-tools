# frozen_string_literal: true

require 'avm/core_ext'
require 'avm/git/issue/complete'

module Avm
  module Tools
    class Runner
      class Git
        class Issue
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Issue operations within Git.'
            subcommands
          end
        end
      end
    end
  end
end
