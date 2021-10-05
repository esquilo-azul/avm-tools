# frozen_string_literal: true

require 'avm/files/formatter/formats/base'

module Avm
  module Files
    class Formatter
      module Formats
        class GenericPlain < ::Avm::Files::Formatter::Formats::Base
          VALID_BASENAMES = %w[*.bat *.css.coffee *.java *.js *.rb *.scss *.sql *.tex *.url *.yml
                               *.yaml].freeze

          VALID_TYPES = %w[plain x-shellscript].freeze

          def internal_apply(files)
            files.each { |file| file_apply(file) }
          end

          def file_apply(file)
            file.write(string_apply(file.read))
          end

          def string_apply(string)
            b = ''
            string.each_line do |line|
              b += "#{line.rstrip}\n"
            end
            "#{b.strip}\n".gsub(/\t/, '  ')
          end
        end
      end
    end
  end
end
