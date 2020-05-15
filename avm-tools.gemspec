# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/tools/version'

Gem::Specification.new do |s|
  s.name        = 'avm-tools'
  s.version     = ::Avm::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for AVM.'

  s.files = Dir['{exe,lib,template}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'aranha-parsers', '~> 0.4'
  s.add_dependency 'clipboard', '~> 1.3', '>= 1.3.3'
  s.add_dependency 'content-type', '~> 0.0.1'
  s.add_dependency 'curb', '~> 0.9.10'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1', '>= 0.1.1'
  s.add_dependency 'eac_cli', '~> 0.3'
  s.add_dependency 'eac_ruby_gems_utils', '~> 0.4'
  s.add_dependency 'eac_ruby_utils', '~> 0.32', '>= 0.32.1'
  s.add_dependency 'filesize'
  s.add_dependency 'git', '~> 1.7'
  s.add_dependency 'htmlbeautifier', '~> 1.3', '>= 1.3.1'
  s.add_dependency 'minitar'
  s.add_dependency 'ruby-progressbar', '~> 1.10', '>= 1.10.1'
end
