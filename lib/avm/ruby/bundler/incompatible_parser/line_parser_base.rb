# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Ruby
    module Bundler
      class IncompatibleParser
        class LineParserBase
          class << self
            def parse(line_content)
              const_get('LINE_PARSER').parse(line_content)
            end
          end
        end
      end
    end
  end
end
