# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'shellwords'

module Avm
  module EacRailsBase1
    class Runner < ::Avm::EacWebappBase0::Runner
      class Bundle < ::EacRubyUtils::Console::DocoptRunner
        runner_with
        runner_definition do
          desc 'Runs "bundle ...".'
          pos_arg :'bundle-args', repeat: true, optional: true
        end

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
