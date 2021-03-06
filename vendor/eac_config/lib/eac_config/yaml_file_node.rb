# frozen_string_literal: true

require 'addressable'
require 'eac_config/node'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/yaml'

module EacConfig
  class YamlFileNode
    require_sub __FILE__
    include ::EacConfig::Node

    class << self
      def from_uri(uri)
        return new(uri.to_addressable.path) if uri.to_addressable.scheme == 'file'
      end
    end

    common_constructor :path do
      self.path = path.to_pathname
    end

    def data
      @data ||= ::EacRubyUtils::Yaml.load_file(assert_path) || {}
    end

    def persist_data(new_data)
      path.parent.mkpath
      ::EacRubyUtils::Yaml.dump_file(path, new_data)
      @data = nil
    end

    def url
      ::Addressable::URI.parse("file://#{path.expand_path}")
    end

    private

    def assert_path
      unless path.file?
        raise("\"#{path}\" is a not a file") if path.exist?

        persist_data({})
      end
      path
    end
  end
end
