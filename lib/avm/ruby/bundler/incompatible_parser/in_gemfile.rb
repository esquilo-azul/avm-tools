# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/ruby/bundler/incompatible_parser/line_parser_base'

module Avm
  module Ruby
    module Bundler
      class IncompatibleParser
        class InGemfile < ::Avm::Ruby::Bundler::IncompatibleParser::LineParserBase
          LINE_PARSER = /In Gemfile:/
                          .to_parser { |_m| new }

          common_constructor
        end
      end
    end
  end
end
