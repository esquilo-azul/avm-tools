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
  s.files = Dir['{lib}/**/*', 'Gemfile']
  s.test_files = Dir['{spec}/**/*', '.rspec']

  s.add_dependency 'bundler'
  s.add_dependency 'eac_fs', '~> 0.8'
  s.add_dependency 'eac_ruby_utils', '~> 0.81'

  # Tests
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
