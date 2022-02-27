# frozen_string_literal: true

require 'avm/data/instance/unit'
require 'eac_ruby_utils/core_ext'
require 'curb'
require 'open-uri'

module Avm
  module EacRedmineBase0
    class DataUnit < ::Avm::Data::Instance::Unit
      common_constructor :instance

      EXPORT_PATH = '/backup/export'
      EXTENSION = '.tar'

      def do_dump(data_path)
        ::File.open(data_path, 'wb') do |file|
          file << URI.parse(export_url).read
        end
      end

      def do_load(data_path)
        do_load_by_web(data_path) || do_load_by_rake(data_path) || raise('Failed to load')
      end

      def do_load_by_web(data_path)
        c = Curl::Easy.new(import_url)
        c.multipart_form_post = true
        c.http_post(Curl::PostField.file('redmine_with_git_tableless_load[path]', data_path))
        c.perform
        true
      rescue Curl::Err::ConnectionFailedError
        false
      end

      def do_load_by_rake(data_path)
        instance.bundle('exec', 'rake', "redmine_with_git:load:all[#{data_path}]").system
        true
      end

      def export_url
        url(EXPORT_PATH)
      end

      def import_url
        url('/backup/import.json')
      end

      def url(path)
        uri = ::Addressable::URI.parse(instance.read_entry('web.url')) + path
        uri.query_values = { key: instance.read_entry('admin.api_key') }
        uri.to_s
      end
    end
  end
end
