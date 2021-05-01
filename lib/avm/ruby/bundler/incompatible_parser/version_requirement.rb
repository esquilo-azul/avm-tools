# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/ruby/bundler/incompatible_parser/line_parser_base'

module Avm
  module Ruby
    module Bundler
      class IncompatibleParser
        class VersionRequirement < ::Avm::Ruby::Bundler::IncompatibleParser::LineParserBase
          LINE_PARSER = /\A([a-z][a-z_0-9]*)(?: \((.+)\))?\z/
                        .to_parser { |m| new(m[1], m[2]) }

          enable_simple_cache
          attr_accessor :stack

          common_constructor :gem_name, :requirements_source

          def data
            { requirements_source: requirements_source, stack: stack.map(&:data) }
          end
        end
      end
    end
  end
end
