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
  s.homepage    = 'https://github.com/esquilo-azul/eac_ruby_gems_utils'
  s.metadata    = { 'source_code_uri' => s.homepage }

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options = ['--charset=UTF-8']

  s.require_paths = ['lib']
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files spec examples`.split("\n")

  s.add_dependency 'eac_ruby_utils', '~> 0.29'

  # Tests
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1'
end
