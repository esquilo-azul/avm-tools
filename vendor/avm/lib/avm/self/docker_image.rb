# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/docker/image'

module Avm
  module Self
    class DockerImage < ::Avm::Docker::Image
      def stereotype_tag
        nil
      end
    end
  end
end
