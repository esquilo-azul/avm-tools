# frozen_string_literal: true

require 'avm/eac_ubuntu_base0/docker_image'
require 'avm/instances/base'

module Avm
  module EacUbuntuBase0
    module Instances
      class Base < ::Avm::Instances::Base
        def docker_image_class
          ::Avm::EacUbuntuBase0::DockerImage
        end

        def file_sudo_write(path, content)
          ::EacRubyUtils::Envs.local.command('echo', content).pipe(
            host_env.command('sudo', 'tee', path)
          ).execute!
        end
      end
    end
  end
end
