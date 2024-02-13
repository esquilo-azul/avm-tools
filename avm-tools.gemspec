# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/tools/version'

Gem::Specification.new do |s|
  s.name        = 'avm-tools'
  s.version     = Avm::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for AVM.'

  s.files = Dir['{exe,lib,template,sub}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'aranha-parsers', '~> 0.22'
  s.add_dependency 'avm', '~> 0.84', '>= 0.84.2'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.33', '>= 0.33.1'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.5'
  s.add_dependency 'avm-files', '~> 0.7'
  s.add_dependency 'avm-git', '~> 0.14'
  s.add_dependency 'clipboard', '~> 1.3', '>= 1.3.6'
  s.add_dependency 'curb', '~> 0.9', '>= 0.9.11'
  s.add_dependency 'eac_git', '~> 0.15'
  s.add_dependency 'eac_ruby_base0', '~> 0.19'
  s.add_dependency 'eac_templates', '~> 0.5'
  s.add_dependency 'git', '~> 1.18'
  s.add_dependency 'ruby-progressbar', '~> 1.13'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.8.1'
end
