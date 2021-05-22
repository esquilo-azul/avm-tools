# frozen_string_literal: true

require 'avm/self/root'
require 'eac_templates/patches/object/template'

::EacTemplates::Searcher.default.included_paths <<
  ::Avm::Self.root.join('template').to_path
