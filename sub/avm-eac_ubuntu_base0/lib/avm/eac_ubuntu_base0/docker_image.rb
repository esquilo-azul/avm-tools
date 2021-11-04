# frozen_string_literal: true

require 'avm/docker/image'
require 'avm/eac_ubuntu_base0/patches/object/template'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacUbuntuBase0
    class DockerImage < ::Avm::Docker::Image
      def stereotype_tag
        'eac_ubuntu_base0'
      end
    end
  end
end
