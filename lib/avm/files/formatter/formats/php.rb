# frozen_string_literal: true

require 'avm/files/formatter/formats/per_file_base'
require 'avm/files/formatter/formats/generic_plain'

module Avm
  module Files
    class Formatter
      module Formats
        class Php < ::Avm::Files::Formatter::Formats::PerFileBase
          VALID_EXTENSIONS = %w[.php].freeze
          VALID_TYPES = ['PHP script'].freeze

          def file_apply(file)
            ::Avm::Executables.php_cs_fixer.command.append(['fix', file]).system!
            ::Avm::Files::Formatter::Formats::GenericPlain.new.file_apply(file)
          end
        end
      end
    end
  end
end
