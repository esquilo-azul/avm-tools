# frozen_string_literal: true

require 'eac_docker/executables'
require 'eac_docker/images/base'
require 'eac_ruby_utils/core_ext'

module EacDocker
  module Images
    class Named < ::EacDocker::Images::Base
      common_constructor :source_tag

      def id
        source_tag
      end

      def provide
        provide_command.execute!
        self
      end

      def provide_command
        ::EacDocker::Executables.docker.command(*docker_provide_args)
      end

      def docker_provide_args
        ['pull', source_tag]
      end
    end
  end
end
