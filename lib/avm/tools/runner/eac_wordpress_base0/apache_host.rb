# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'avm/stereotypes/eac_wordpress_base0/apache_host'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class ApacheHost
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Configure Apache virtual host for EacWordpressBase0 instance.'
          end

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
