# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/docker/image'

module Avm
  module Stereotypes
    module EacUbuntuBase0
      class DockerImage < ::Avm::Docker::Image
        enable_simple_cache
        common_constructor :registry

        def tag
          "#{registry.name}:eac_ubuntu_base0"
        end
      end
    end
  end
end
