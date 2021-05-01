# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/ruby/bundler/incompatible_parser/line_parser_base'

module Avm
  module Ruby
    module Bundler
      class IncompatibleParser
        class DependsOn < ::Avm::Ruby::Bundler::IncompatibleParser::LineParserBase
          LINE_PARSER = /(.+) was resolved to (.+), which depends on/
                        .to_parser { |m| new(m[1], m[2]) }

          common_constructor :gem_name, :version do
            self.version = ::Gem::Version.new(version)
          end

          def data
            { gem_name: gem_name, version: version }
          end
        end
      end
    end
  end
end
