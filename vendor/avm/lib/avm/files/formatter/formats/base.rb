# frozen_string_literal: true

require 'eac_fs/file_info'
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
            match_by_filename?(file) || match_by_type?(file)
          end

          def valid_basenames
            constant_or_array('VALID_BASENAMES')
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

          def match_by_filename?(file)
            valid_basenames.any? do |valid_basename|
              file.basename.fnmatch?(valid_basename)
            end
          end

          def match_by_type?(file)
            info = ::EacFs::FileInfo.new(file)
            return unless info.content_type.type == 'text'

            valid_types.include?(info.content_type.subtype)
          end
        end
      end
    end
  end
end
