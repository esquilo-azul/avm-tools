# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/stereotypes/eac_wordpress_base0/apache_host'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class ApacheHost < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Configure Apache virtual host for EacWordpressBase0 instance.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help                       Show this screen.
          DOCOPT

          def run
            result = ::Avm::Stereotypes::EacWordpressBase0::ApacheHost.new(
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
