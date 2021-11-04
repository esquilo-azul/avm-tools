# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'content-type'
require 'filemagic'

module EacFs
  class FileInfo
    UNKNOWN_CONTENT_TYPE_STRING = 'application/octet-stream'
    UNKNOWN_CONTENT_TYPE = ::ContentType.parse(UNKNOWN_CONTENT_TYPE_STRING)

    enable_simple_cache
    attr_reader :magic_string

    def initialize(path)
      @magic_string = ::FileMagic.new(FileMagic::MAGIC_MIME).file(path.to_pathname.to_path)
    end

    delegate :charset, :mime_type, :subtype, :type, to: :content_type

    private

    def content_type_uncached
      ::ContentType.parse(magic_string)
    rescue ::Parslet::ParseFailed
      UNKNOWN_CONTENT_TYPE
    end
  end
end
