# frozen_string_literal: true

require 'avm/docker/runner'
require 'avm/runners/base'
require 'eac_ruby_utils/struct'

module Avm
  module EacUbuntuBase0
    module Runners
      class Base < ::Avm::Runners::Base
        class Docker < ::Avm::Docker::Runner
          def use_default_registry?
            true
          end
        end
      end
    end
  end
end
