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
          __PROGRAM__ [options] [-B <build-arg>...]
          __PROGRAM__ -h | --help

        Options:
          -h --help     Show this help.
          -n --registry-name=<registry-name>    Docker registry's name.
          -p --push     Push the image to Docker registry.
          -r --run      Run or start a container with builded image.
          -B --build-arg=<build-arg>  Argument for "docker build".
          -c --clear  Remove container if exist before run.
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
        instance.docker_registry = registry
      end

      def banner
        infov 'Registry name', registry
        infov 'Image name', instance.docker_image.tag
        infov 'Build arguments', build_args
      end

      def build
        instance.docker_image.build(build_args)
      end

      def build_args
        options.fetch('--build-arg')
      end

      def push
        instance.docker_image.push if options.fetch('--push')
      end

      def container_run
        instance.docker_container.run(clear: options.fetch('--clear')) if options.fetch('--run')
      end

      def registry_uncached
        options.fetch('--registry-name').if_present(::Avm::Docker::Registry.default) do |v|
          ::Avm::Docker::Registry.new(v)
        end
      end

      def instance
        context(:instance)
      end
    end
  end
end
