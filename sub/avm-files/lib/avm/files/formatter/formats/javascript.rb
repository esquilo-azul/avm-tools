# frozen_string_literal: true

require 'avm/executables'
require 'avm/files/formatter/formats/generic_plain'

module Avm
  module Files
    class Formatter
      module Formats
        class Javascript < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.js].freeze
          VALID_TYPES = [].freeze

          def internal_apply(files)
            ::Avm::Executables.js_beautify.command.append(
              ['--indent-size=2', '--end-with-newline', '--replace', *files]
            ).system!
            super(files)
          end
        end
      end
    end
  end
end
