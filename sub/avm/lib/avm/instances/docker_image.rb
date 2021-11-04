# frozen_string_literal: true

require 'avm/docker/image'

module Avm
  module Instances
    class DockerImage < ::Avm::Docker::Image
      attr_accessor :instance

      def stereotype_tag
        instance.id
      end
    end
  end
end
