# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_templates/patches/object/template'

::EacTemplates::Searcher.default.included_paths <<
  __dir__.to_pathname.expand_path.parent_n(5).join('template')
