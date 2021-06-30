# frozen_string_literal: true

require 'avm/self/instance'
require 'eac_docker/registry'
require 'eac_ruby_utils/core_ext'

module Avm
  module Docker
    class Registry < ::EacDocker::Registry
    end
  end
end
