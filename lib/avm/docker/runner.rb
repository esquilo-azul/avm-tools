# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'
require 'avm/docker/registry'

module Avm
  module Docker
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      enable_console_speaker
      enable_simple_cache

      DOC = <<~DOCOPT
        Manipulate Docker images.

        Usage:
          __PROGRAM__ [options] [-B <build-arg>...] [-E <run-arg>...]
          __PROGRAM__ -h | --help

        Options:
          -h --help     Show this help.
          -n --registry-name=<registry-name>    Docker registry's name.
          -p --push     Push the image to Docker registry.
          -r --run      Run or start a container with builded image.
          -B --build-arg=<build-arg>  Argument for "docker build".
          -E --entrypoint-arg=<run-arg>    Argument for entrypoint on "docker run"
          -c --clear  Remove container if exist before run.
          -V --no-version   Does not add version to image tag.
      DOCOPT

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
          version: version?
        }
      end

      def banner
        infov 'Registry name', registry
        infov 'Version?', version?
        infov 'Image name', instance.docker_image.tag
        infov 'Build arguments', build_args
        infov 'Entrypoint arguments', entrypoint_args
      end

      def build
        instance.docker_image.build(build_args)
      end

      def build_args
        options.fetch('--build-arg')
      end

      def entrypoint_args
        options.fetch('--entrypoint-arg')
      end

      def push
        instance.docker_image.push if options.fetch('--push')
      end

      def container_run
        return unless options.fetch('--run')

        instance.docker_container.run(
          entrypoint_args: entrypoint_args,
          clear: options.fetch('--clear')
        )
      end

      def registry_uncached
        options.fetch('--registry-name').if_present(::Avm::Docker::Registry.default) do |v|
          ::Avm::Docker::Registry.new(v)
        end
      end

      def version?
        !options.fetch('--no-version')
      end

      def instance
        context(:instance)
      end
    end
  end
end
