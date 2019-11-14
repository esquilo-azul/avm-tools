# frozen_string_literal: true

require 'eac_ruby_utils/patches/object/template'

::EacRubyUtils::Templates::Searcher.default.included_paths << ::File.expand_path(
  ('../' * 4) + 'template', __dir__
)
