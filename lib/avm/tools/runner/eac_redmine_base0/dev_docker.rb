# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module Tools
    class Runner
      class EacRedmineBase0 < ::Avm::EacRailsBase1::Runner
        class DevDocker < ::Avm::Docker::Runner
          def docker_image
            ::Avm::EacUbuntuBase0::DockerImage
          end
        end
      end
    end
  end
end
