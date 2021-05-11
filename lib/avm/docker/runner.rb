# frozen_string_literal: true

require 'avm/core_ext'
require 'avm/docker/registry'

module Avm
  module Docker
    class Runner
      enable_speaker
      enable_simple_cache

      runner_with :help do
        desc 'Manipulate Docker images.'
        arg_opt '-n', '--registry-name', 'Docker registry\'s name.'
        bool_opt '-p', '--push', 'Push the image to Docker registry.'
        bool_opt '-r', '--run', 'Run or start a container with builded image.'
        arg_opt '-B', '--build-arg', 'Argument for "docker build".', repeat: true
        arg_opt '-E', '--entrypoint-arg', 'Argument for entrypoint on "docker run"', repeat: true
        bool_opt '-c', '--clear', 'Remove container if exist before run.'
        bool_opt '-S', '--no-snapshot', 'Does not add "-snapshot" to image tag.'
        bool_opt '-V', '--no-version', 'Does not add version to image tag.'
      end

      def run
        setup
        banner
        build
        push
        container_run
      end

      private

      def setup
        instance.docker_image_options = {
          registry: registry,
          snapshot: snapshot?,
          version: version?
        }
      end

      def banner
        infov 'Registry name', registry
        infov 'Version?', version?
        infov 'Snapshot?', snapshot?
        infov 'Image name', docker_image.tag
        infov 'Build arguments', build_args
        infov 'Entrypoint arguments', entrypoint_args
      end

      def build
        docker_image.build(build_args)
        success 'Docker image builded'
      end

      def build_args
        parsed.build_arg
      end

      def docker_container
        instance.docker_container
      end

      def docker_image
        instance.docker_image
      end

      def entrypoint_args
        parsed.entrypoint_arg
      end

      def push
        docker_image.push if parsed.push?
      end

      def container_run
        return unless parsed.run?

        docker_container.run(
          entrypoint_args: entrypoint_args,
          clear: parsed.clear?
        )
      end

      def registry_uncached
        registry_from_option || ::Avm::Docker::Registry.default
      end

      def registry_from_option
        parsed.registry_name.if_present { |v| ::Avm::Docker::Registry.new(v) }
      end

      def snapshot?
        !parsed.no_snapshot?
      end

      def version?
        !parsed.no_version?
      end

      def instance
        runner_context.call(:instance)
      end
    end
  end
end
