# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/ruby/bundler/incompatible_parser/depends_on'
require 'avm/ruby/bundler/incompatible_parser/gem_conflict'
require 'avm/ruby/bundler/incompatible_parser/in_gemfile'

module Avm
  module Ruby
    module Bundler
      class IncompatibleParser
        class LineFactory
          TYPES = [GemConflict, InGemfile, DependsOn, VersionRequirement].freeze

          enable_simple_cache
          common_constructor :content do
            self.content = content.strip
          end

          delegate :blank?, to: :content

          private

          def result_uncached
            TYPES.lazy.map { |type| type.parse(content) }.find(&:present?)
          end
        end
      end
    end
  end
end
