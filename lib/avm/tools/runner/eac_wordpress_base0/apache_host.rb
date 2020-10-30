# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner/apache_host'
require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'avm/eac_wordpress_base0/apache_host'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        class ApacheHost < ::Avm::EacWebappBase0::Runner::ApacheHost
        end
      end
    end
  end
end
