# frozen_string_literal: true

require 'eac_config/yaml_file_node'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'
require 'shellwords'

module Avm
  module Sources
    class Base
      module Configuration
        CONFIGURATION_FILENAMES = %w[.avm.yml .avm.yaml].freeze

        # @return [Array<String>, nil]
        def read_configuration_as_shell_words(key)
          configuration.entry(key).value.if_present do |v|
            v.is_a?(::Enumerable) ? v.map(&:to_s) : ::Shellwords.split(v.to_s)
          end
        end

        # Utility to read a configuration as a [EacRubyUtils::Envs::Command].
        # @return [EacRubyUtils::Envs::Command]
        def read_configuration_as_env_command(key)
          read_configuration_as_shell_words(key).if_present do |v|
            env.command(v).chdir(path)
          end
        end

        private

        # @return [EacConfig::YamlFileNode]
        def configuration_uncached
          CONFIGURATION_FILENAMES.each do |filename|
            configuration_with_filename(filename, true)
          end
          configuration_with_filename(CONFIGURATION_FILENAMES.first, false)
        end

        # @return [EacConfig::YamlFileNode, nil]
        def configuration_with_filename(filename, needs_exist)
          file_path = path.join(filename)
          return ::EacConfig::YamlFileNode.new(file_path) if !needs_exist || file_path.exist?

          nil
        end

        # @return [Avm::Sources::Configuration]
        def old_configuration_uncached
          ::Avm::Sources::Configuration.find_in_path(path) ||
            ::Avm::Sources::Configuration.temp_instance
        end
      end
    end
  end
end
