# frozen_string_literal: true

require 'eac_docker/executables'

module EacDocker
  module Rspec
    module Setup
      def self.extended(obj)
        obj.setup_conditional_docker_executable
      end

      def setup_conditional_docker_executable
        conditional(:docker) { ::EacDocker::Executables.docker.validate }
      end
    end
  end
end
