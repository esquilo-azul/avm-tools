# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Ruby
          require_sub __FILE__
          runner_with :help, :subcommands do
            desc 'Ruby utitilies for local projects.'
            subcommands
          end
        end
      end
    end
  end
end
