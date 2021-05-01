# frozen_string_literal: true

require 'avm/ruby/bundler/incompatible_parser'

RSpec.describe ::Avm::Ruby::Bundler::IncompatibleParser do
  include_examples 'source_target_fixtures', __FILE__
end
