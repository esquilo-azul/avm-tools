# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner'
require 'avm/eac_writings_base1'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class EacWritingsBase1 < ::Avm::EacWebappBase0::Runner
        require_sub __FILE__
      end
    end
  end
end
