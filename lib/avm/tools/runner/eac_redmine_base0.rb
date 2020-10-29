# frozen_string_literal: true

require 'avm/eac_rails_base1/runner'
require 'avm/eac_redmine_base0'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::Avm::EacRailsBase1::Runner
        require_sub __FILE__
      end
    end
  end
end
