# frozen_string_literal: true

require 'avm/self'
require 'eac_ruby_utils/patches/object/template'

::EacRubyUtils::Templates::Searcher.default.included_paths <<
  ::Avm::Self.root.join('template').to_path
