# frozen_string_literal: true

require 'avm/executables'
require 'avm/files/formatter/formats/generic_plain'

module Avm
  module Files
    class Formatter
      module Formats
        class Python < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.py].freeze
          VALID_TYPES = ['x-python'].freeze

          def internal_apply(files)
            ::Avm::Executables.yapf.command.append(['--in-place', *files]).system!
            super(files)
          end
        end
      end
    end
  end
end
