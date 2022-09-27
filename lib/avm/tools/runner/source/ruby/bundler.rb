# frozen_string_literal: true

require 'eac_ruby_base0/core_ext'

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Ruby
          class Bundler
            require_sub __FILE__
            runner_with :help, :subcommands do
              desc 'Ruby\'s bundler utitilies for local projects.'
              subcommands
            end
          end
        end
      end
    end
  end
end
