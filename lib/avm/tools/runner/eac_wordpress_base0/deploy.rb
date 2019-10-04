# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'avm/stereotypes/eac_wordpress_base0/deploy'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Deploy < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Deploy for EacWordpressBase0 instance.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help                       Show this screen.
              -r --reference=<git-reference>  Git reference to deploy.
          DOCOPT

          def run
            result = ::Avm::Stereotypes::EacWordpressBase0::Deploy.new(
              context(:instance),
              options.fetch('--reference')
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
