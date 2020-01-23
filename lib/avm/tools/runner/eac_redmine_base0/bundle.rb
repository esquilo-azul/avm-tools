# frozen_string_literal: true

require 'avm/stereotypes/eac_redmine_base0/deploy'
require 'avm/stereotypes/eac_webapp_base0/runner/deploy'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
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
end
