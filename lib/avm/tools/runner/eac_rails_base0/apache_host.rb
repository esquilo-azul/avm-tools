# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/stereotypes/eac_rails_base0/apache_host'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::EacRubyUtils::Console::DocoptRunner
        class ApacheHost < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Deploy for EacRailsBase0 instance.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help                       Show this screen.
              -r --reference=<git-reference>  Git reference to deploy.
          DOCOPT

          def run
            result = ::Avm::Stereotypes::EacRailsBase0::ApacheHost.new(
              context(:instance)
            ).run
            if result.error?
              fatal_error result.to_s
            else
              infov 'Result', result.label
            end
          end
        end
      end
    end
  end
end
