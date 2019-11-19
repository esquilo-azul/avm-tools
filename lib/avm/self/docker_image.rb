# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/docker/image'

module Avm
  module Self
    class DockerImage < ::Avm::Docker::Image
      common_constructor :registry

      def tag
        registry.name
      end
    end
  end
end
