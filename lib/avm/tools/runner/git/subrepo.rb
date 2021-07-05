# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class Git
        class Subrepo
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Git-subrepo (https://github.com/ingydotnet/git-subrepo) utilities.'
            subcommands
          end
        end
      end
    end
  end
end
