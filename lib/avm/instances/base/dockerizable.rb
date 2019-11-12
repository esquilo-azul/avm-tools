# frozen_string_literal: true

require 'avm/docker/container'

module Avm
  module Instances
    class Base
      module Dockerizable
        enable_simple_cache
        attr_reader :docker_registry

        def docker_registry=(new_value)
          @docker_registry = new_value
          reset_cache
        end

        def docker_container_exist?
          ::Avm::Executables.docker.command.append(
            ['ps', '-qaf', "name=#{docker_container_name}"]
          ).execute!.present?
        end

        def docker_container_name
          id
        end

        private

        def docker_container_uncached
          ::Avm::Docker::Container.new(self)
        end

        def docker_image_uncached
          docker_image_class.new(docker_registry)
        end
      end
    end
  end
end
