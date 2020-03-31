# frozen_string_literal: true

require 'avm/files/info'
require 'ostruct'

module Avm
  module Files
    class Formatter
      module Formats
        class Base
          def apply(files)
            old_content = Hash[files.map { |f| [f, File.read(f)] }]
            ::Avm::Files::Formatter::Utf8Assert.assert_files(files) { internal_apply(files) }
            files.map { |f| build_file_result(f, old_content[f]) }
          end

          def name
            self.class.name.demodulize
          end

          def match?(file)
            match_by_extension?(file) || match_by_type?(file)
          end

          def valid_extensions
            constant_or_array('VALID_EXTENSIONS')
          end

          def valid_types
            constant_or_array('VALID_TYPES')
          end

          private

          def constant_or_array(name)
            return [] unless self.class.const_defined?(name)

            self.class.const_get(name)
          end

          def build_file_result(file, old_content)
            ::OpenStruct.new(file: file, format: self.class,
                             changed: (old_content != File.read(file)))
          end

          def match_by_extension?(file)
            valid_extensions.any? do |valid_extension|
              file.extname.ends_with?(valid_extension)
            end
          end

          def match_by_type?(file)
            info = ::Avm::Files::Info.new(file)
            return unless info.content_type.type == 'text'

            valid_types.include?(info.content_type.subtype)
          end
        end
      end
    end
  end
end
