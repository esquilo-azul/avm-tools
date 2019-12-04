# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/executables'
require 'avm/patches/object/template'

module Avm
  module Docker
    class Image
      attr_reader :registry

      def initialize(registry)
        @registry = registry
      end

      def build(extra_args = [])
        on_build_dir do
          template.apply(self, build_dir)
          run_docker_build(extra_args)
        end
      end

      def push
        ::Avm::Executables.docker.command.append(['push', tag]).system!
      end

      def read_entry(path, _options = {})
        method = path.gsub('.', '_')
        return send(method) if respond_to?(path, true)

        raise "Method \"#{method}\" not found for entry \"#{path}\""
      end

      def run(instance)
        run_run(instance) if container_exist?(instance)
      end

      def tag
        r = tag_name
        r += ":#{tag_version}" if tag_version.present?
        r
      end

      def tag_name
        return registry.name if registry.name.present?

        raise 'Registry name is blank'
      end

      def tag_version
        stereotype_tag
      end

      private

      attr_reader :build_dir

      def run_docker_build(extra_args)
        ::Avm::Executables.docker.command.append(
          ['build', '-t', tag] + extra_args + [build_dir]
        ).system!
      end

      def on_build_dir
        @build_dir = ::Dir.mktmpdir
        yield
      ensure
        ::FileUtils.rm_rf(@build_dir)
      end
    end
  end
end
