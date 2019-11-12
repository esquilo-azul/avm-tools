# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/executables'

module Avm
  module Docker
    class Container
      enable_console_speaker
      common_constructor :instance

      def remove
        ::Avm::Executables.docker.command.append(
          ['rm', '--force', instance.docker_container_name]
        ).system!
      end

      def run(options = {})
        infov 'Container name', instance.docker_container_name
        infov 'Container exist?', instance.docker_container_exist?
        remove if options[:clear] && instance.docker_container_exist?
        if instance.docker_container_exist?
          run_start
        else
          run_run
        end
      end

      def run_run
        infom "\"docker run #{instance.docker_container_name}...\""
        ::Avm::Executables.docker.command.append(run_run_arguments).system!
      end

      def run_start
        infom "\"docker start #{instance.docker_container_name}...\""
        ::Avm::Executables.docker.command.append(run_start_arguments).system!
      end

      def run_run_arguments
        ['run', '-it', '--name', instance.docker_container_name] + instance.docker_run_arguments +
          [instance.docker_image.tag]
      end

      def run_start_arguments
        ['start', '-ai', instance.docker_container_name]
      end
    end
  end
end
