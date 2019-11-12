# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/stereotypes/eac_ubuntu_base0/docker_image'

module Avm
  module Stereotypes
    module EacRedmineBase0
      class Instance < ::Avm::Instances::Base
        def docker_image_class
          ::Avm::Stereotypes::EacUbuntuBase0::DockerImage
        end

        def docker_run_arguments
          [
            '--volume', "#{read_entry(:fs_path)}:/home/myuser/eac_redmine_base0",
            '--publish', "#{read_entry(:ssh_port)}:22",
            '--publish', "#{read_entry(:http_port)}:80",
            '--publish', "#{read_entry(:https_port)}:443"
          ]
        end
      end
    end
  end
end
