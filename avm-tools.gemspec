# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/tools/version'

Gem::Specification.new do |s|
  s.name        = 'avm-tools'
  s.version     = Avm::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for AVM.'

  s.files = Dir['{exe,lib}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'avm', '~> 0.96'
  s.add_dependency 'clipboard', '~> 1.4', '>= 1.4.1'
  s.add_dependency 'eac_ruby_base0', '~> 0.19', '>= 0.19.1'

  s.add_development_dependency 'avm-git', '~> 0.20'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.11', '>= 0.11.1'
end
