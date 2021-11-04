# frozen_string_literal: true

require 'avm/files/formatter/formats/generic_plain'
require 'avm/ruby/rubocop'

module Avm
  module Files
    class Formatter
      module Formats
        class Ruby < ::Avm::Files::Formatter::Formats::GenericPlain
          VALID_BASENAMES = %w[*.gemspec *.rake *.rb Gemfile Rakefile].freeze
          VALID_TYPES = ['x-ruby'].freeze

          def internal_apply(files)
            ::Avm::Ruby::Rubocop.new('.', ['-a', '--ignore-parent-exclusion'] + files).run
            super(files)
          end
        end
      end
    end
  end
end
