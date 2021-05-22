# frozen_string_literal: true

require 'eac_templates/patches/object/template'

::EacTemplates::Searcher.default.included_paths << ::File.join(__dir__, 'stub_templates')
