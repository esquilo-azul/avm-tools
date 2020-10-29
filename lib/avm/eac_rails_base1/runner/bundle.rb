# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'shellwords'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Bundle < ::EacRubyUtils::Console::DocoptRunner
        enable_console_speaker

        DOC = <<~DOCOPT
          Runs "bundle ...".

          Usage:
            __PROGRAM__ [<bundle-args>...]
            __PROGRAM__ -h | --help

          Options:
            -h --help                 Show this screen.
        DOCOPT

        def run
          infov 'Bundle arguments', ::Shellwords.join(bundle_args)
          context(:instance).bundle(*bundle_args).system!
        end

        def bundle_args
          options.fetch('<bundle-args>').reject { |arg| arg == '--' }
        end
      end
    end
  end
end
