# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/docker/image'

module Avm
  module EacUbuntuBase0
    class DockerImage < ::Avm::Docker::Image
      def stereotype_tag
        'eac_ubuntu_base0'
      end
    end
  end
end
