# frozen_string_literal: true

require 'avm/executables'
require 'avm/files/formatter/formats/generic_plain'

module Avm
  module Files
    class Formatter
      module Formats
        class Php < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.php].freeze
          VALID_TYPES = ['x-php'].freeze

          def file_apply(file)
            ::Avm::Executables.php_cs_fixer.command.append(['fix', file]).system!
            super(file)
          end
        end
      end
    end
  end
end
