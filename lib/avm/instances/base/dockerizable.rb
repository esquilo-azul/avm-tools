# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/docker/container'

module Avm
  module Instances
    class Base
      module Dockerizable
        enable_simple_cache
        attr_reader :docker_image_options

        def docker_image_options=(options)
          @docker_image_options = ::ActiveSupport::HashWithIndifferentAccess.new(options)
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
          docker_image_class.new(docker_image_options.fetch(:registry))
        end
      end
    end
  end
end
