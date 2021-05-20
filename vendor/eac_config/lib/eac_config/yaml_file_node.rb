# frozen_string_literal: true

require 'addressable'
require 'eac_config/entry'
require 'eac_config/entry_search'
require 'eac_config/node'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'

module EacConfig
  class YamlFileNode
    include ::EacConfig::Node

    common_constructor :path do
      self.path = path.to_pathname
    end

    def data
      @data ||= ::EacRubyUtils::Yaml.load_file(path)
    end

    def url
      ::Addressable::URI.parse("file://#{path.expand_path}")
    end
  end
end