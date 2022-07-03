# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/tools/version'

Gem::Specification.new do |s|
  s.name        = 'avm-tools'
  s.version     = ::Avm::Tools::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Tools for AVM.'

  s.files = Dir['{exe,lib,template,sub}/**/*', 'Gemfile']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'aranha-parsers', '~> 0.4'
  s.add_dependency 'avm', '~> 0.21'
  s.add_dependency 'avm-eac_asciidoctor_base0', '~> 0.3', '>= 0.3.4'
  s.add_dependency 'avm-eac_rails_base0', '~> 0.3'
  s.add_dependency 'avm-eac_redmine_base0', '~> 0.5', '>= 0.5.2'
  s.add_dependency 'avm-eac_redmine_plugin_base0', '~> 0.1'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.7'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.3'
  s.add_dependency 'avm-files', '~> 0.1'
  s.add_dependency 'avm-git', '~> 0.3', '>= 0.3.1'
  s.add_dependency 'clipboard', '~> 1.3', '>= 1.3.3'
  s.add_dependency 'curb', '~> 0.9.10'
  s.add_dependency 'eac_ruby_base0', '~> 0.16', '>= 0.16.4'
  s.add_dependency 'git', '~> 1.7'
  s.add_dependency 'ruby-progressbar', '~> 1.10', '>= 1.10.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
