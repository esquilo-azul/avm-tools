# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/tools/version'

Gem::Specification.new do |s|
  s.name        = 'avm-tools'
  s.version     = ::Avm::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for AVM.'

  s.files = Dir['{exe,lib}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'aranha-parsers', '~> 0.1', '>= 0.1.1'
  s.add_dependency 'clipboard', '~> 1.3', '>= 1.3.3'
  s.add_dependency 'eac_launcher', '~> 0.6', '>= 0.6.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.13'
  s.add_dependency 'filesize'
  s.add_dependency 'minitar'
  s.add_development_dependency 'rspec', '3.8'
  s.add_development_dependency 'rubocop', '~> 0.74.0'
  s.add_development_dependency 'rubocop-rspec', '~> 1.34', '>= 1.34.1'
end
