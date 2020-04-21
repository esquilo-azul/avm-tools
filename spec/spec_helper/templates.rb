# frozen_string_literal: true

require 'eac_ruby_utils/patches/object/template'

::EacRubyUtils::Templates::Searcher.default.included_paths << ::File.join(__dir__, 'stub_templates')
