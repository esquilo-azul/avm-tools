# frozen_string_literal: true

require 'avm/tools/core_ext'
require 'avm/ruby/rubocop'

module Avm
  module Tools
    class Runner
      class Ruby
        class Rubocop
          runner_with :help do
            desc 'Runs Rubocop (https://rubygems.org/gems/rubocop).'
            arg_opt '-C', 'Caminho para executar o Rubocop [default: .].'
            pos_arg :rubocop_args, repeat: true, optional: true
          end

          def run
            ::Avm::Ruby::Rubocop.new(path, parsed.rubocop_args).run
          end

          private

          def path
            ::Pathname.new(parsed.c || '.').expand_path
          end
        end
      end
    end
  end
end
