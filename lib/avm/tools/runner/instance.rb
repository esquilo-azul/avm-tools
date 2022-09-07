# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/instances/runner'
require 'avm/registry'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        require_sub __FILE__
      end
    end
  end
end
