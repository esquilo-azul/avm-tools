# frozen_string_literal: true

require 'avm/executables'
require 'eac_ruby_utils/core_ext'
require 'content-type'

module Avm
  module Files
    class Info
      enable_simple_cache
      common_constructor :path

      private

      def content_type_uncached
        ::ContentType.parse(
          ::Avm::Executables.file.command.append(['-ib', path]).execute!.strip
        )
      end
    end
  end
end
