# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/simple_cache'
require 'avm/stereotypes/eac_wordpress_base0/instance'
require 'avm/tools/runner/eac_wordpress_base0/apache_host'
require 'avm/tools/runner/eac_wordpress_base0/data'
require 'avm/tools/runner/eac_wordpress_base0/deploy'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacWordpressBase0 < ::EacRubyUtils::Console::DocoptRunner
        include ::EacRubyUtils::SimpleCache

        DOC = <<~DOCOPT
          Utilities for EacWordpressBase0 instances.

          Usage:
            __PROGRAM__ [options] <instance_id> __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
        DOCOPT

        private

        def instance_uncached
          ::Avm::Stereotypes::EacWordpressBase0::Instance.by_id(options['<instance_id>'])
        end
      end
    end
  end
end
