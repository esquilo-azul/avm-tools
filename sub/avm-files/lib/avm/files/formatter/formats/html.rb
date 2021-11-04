# frozen_string_literal: true

require 'avm/files/formatter/formats/generic_plain'
require 'htmlbeautifier'

module Avm
  module Files
    class Formatter
      module Formats
        class Html < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.html *.html.erb].freeze
          VALID_TYPES = ['html'].freeze

          def file_apply(path)
            input = ::File.read(path)
            temppath = tempfile_path
            ::File.open(temppath, 'w') do |output|
              beautify path, input, output
            end
            ::FileUtils.mv(temppath, path)
            super(path)
          end

          private

          def beautify(name, input, output)
            output.puts ::HtmlBeautifier.beautify(input, htmlbeautify_options)
          rescue StandardError => e
            raise "Error parsing #{name}: #{e}"
          end

          def htmlbeautify_options
            @htmlbeautify_options ||= { indent: '  ' }
          end

          def tempfile_path
            tempfile = ::Tempfile.new
            tempfile.close
            tempfile.path
          end
        end
      end
    end
  end
end
