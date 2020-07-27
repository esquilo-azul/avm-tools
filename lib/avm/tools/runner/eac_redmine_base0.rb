# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/simple_cache'
require 'avm/eac_redmine_base0/instance'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        include ::EacRubyUtils::SimpleCache

        DOC = <<~DOCOPT
          Utilities for EacRedmineBase0 instances.

          Usage:
            __PROGRAM__ [options] <instance_id> __SUBCOMMANDS__
            __PROGRAM__ -h | --help

          Options:
            -h --help             Show this screen.
        DOCOPT

        private

        def instance_uncached
          ::Avm::EacRedmineBase0::Instance.by_id(options['<instance_id>'])
        end
      end
    end
  end
end
