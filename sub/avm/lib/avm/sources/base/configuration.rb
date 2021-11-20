# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'

module Avm
  module Sources
    class Base
      module Configuration
        private

        # @return [Hash]
        def configuration_uncached
          ::Avm::Sources::Configuration::FILENAMES.each do |filename|
            file_path = path.join(filename)
            return ::EacRubyUtils::Yaml.load_file(file_path).with_indifferent_access if
            file_path.exist?
          end
          {}
        end

        # @return [Avm::Sources::Configuration]
        def old_configuration_uncached
          ::Avm::Sources::Configuration.find_in_path(path)
        end
      end
    end
  end
end
