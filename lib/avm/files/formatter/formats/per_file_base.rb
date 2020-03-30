# frozen_string_literal: true

require 'avm/files/formatter/formats/base'

module Avm
  module Files
    class Formatter
      module Formats
        class PerFileBase < ::Avm::Files::Formatter::Formats::Base
          def internal_apply(files)
            files.each { |file| file_apply(file) }
          end
        end
      end
    end
  end
end
