# frozen_string_literal: true

require 'avm/self/instance'
require 'eac_docker/registry'
require 'eac_ruby_utils/core_ext'

module Avm
  module Docker
    class Registry < ::EacDocker::Registry
      class << self
        def default
          @default ||= new(::Avm::Self.instance.read_entry(
                             ::Avm::Self::Instance::EntryKeys::DOCKER_REGISTRY_NAME
                           ))
        end
      end
    end
  end
end
