# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/self/docker_image'
require 'avm/self/instance/entry_keys'
require 'avm/stereotypes/eac_ubuntu_base0/docker_image'

module Avm
  module Self
    class Instance < ::Avm::Instances::Base
      def docker_image_class
        ::Avm::Self::DockerImage
      end

      def docker_run_arguments
        ['-e', "LOCAL_USER_ID=#{::Process.uid}"]
      end
    end
  end
end
