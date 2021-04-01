# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_git/version'

Gem::Specification.new do |s|
  s.name        = 'eac_git'
  s.version     = EacGit::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,vendor}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.37'
  s.add_dependency 'parseconfig', '~> 1.0', '>= 1.0.8'

  s.add_development_dependency 'aranha-parsers', '~> 0.7'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1', '>= 0.1.2'
end
