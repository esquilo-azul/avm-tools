# frozen_string_literal: true

require 'avm/executables'
require 'avm/files/formatter/formats/generic_plain'

module Avm
  module Files
    class Formatter
      module Formats
        class Xml < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.xml].freeze
          VALID_TYPES = ['xml'].freeze

          def internal_apply(files)
            format_command(files).system!
            super(files)
          end

          def format_command(files)
            ::Avm::Executables.tidy.command.append(
              %w[-xml -modify --indent auto --indent-spaces 2 --wrap 100] + files
            )
          end
        end
      end
    end
  end
end
