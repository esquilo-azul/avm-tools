# frozen_string_literal: true

require 'avm/data/instance/unit'
require 'eac_ruby_utils/core_ext'
require 'open-uri'

module Avm
  module EacRedmineBase0
    class DataUnit < ::Avm::Data::Instance::Unit
      common_constructor :instance

      EXTENSION = '.tar'

      def do_dump(data_path)
        ::File.open(data_path, 'wb') do |file|
          file << URI.parse(export_url).read
        end
      end

      def export_url
        uri = ::Addressable::URI.parse(instance.read_entry('web.url')) + '/backup/export'
        uri.query_values = { key: instance.read_entry('admin.api_key') }
        uri.to_s
      end
    end
  end
end
