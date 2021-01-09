# frozen_string_literal: true

require 'avm/ruby/rubocop'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class Ruby < ::EacRubyUtils::Console::DocoptRunner
        class Rubocop < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker
          include ::EacRubyUtils::SimpleCache

          DOC = <<~DOCOPT
            Runs Rubocop (https://rubygems.org/gems/rubocop).

            Usage:
              __PROGRAM__ [options] [<rubocop-args>...]
              __PROGRAM__ -h | --help

            Options:
              -h --help               Show this screen.
              -C=<path>               Caminho para executar o Rubocop [default: .].
          DOCOPT

          def run
            ::Avm::Ruby::Rubocop.new(path, rubocop_args).run
          end

          private

          def path
            ::Pathname.new(options.fetch('-C')).expand_path
          end

          def rubocop_args
            r = options.fetch('<rubocop-args>')
            r.shift if r.first == '--'
            r
          end
        end
      end
    end
  end
end
