# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner'
require 'avm/eac_wordpress_base0'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class EacWordpressBase0 < ::Avm::EacWebappBase0::Runner
        require_sub __FILE__
      end
    end
  end
end
