# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'eac_ruby_gems_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'eac_ruby_gems_utils'
  s.version     = ::EacRubyGemsUtils::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Utilities for Ruby gems development.'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'README.rdoc']

  s.add_dependency 'eac_ruby_utils', '~> 0.29'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1'
end
