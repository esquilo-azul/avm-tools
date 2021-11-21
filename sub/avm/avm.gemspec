# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/version'

Gem::Specification.new do |s|
  s.name        = 'avm'
  s.version     = Avm::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Ruby base library for Agora Vai! Methodology (https://avm.esquiloazul.tech).'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_cli', '~> 0.23', '>= 0.23.1'
  s.add_dependency 'eac_docker', '~> 0.3'
  s.add_dependency 'eac_git', '~> 0.6'
  s.add_dependency 'eac_ruby_utils', '~> 0.80'
  s.add_dependency 'eac_templates', '~> 0.1', '>= 0.1.1'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'htmlbeautifier', '~> 1.3', '>= 1.3.1'
  s.add_dependency 'minitar', '~> 0.9'

  s.add_development_dependency 'aranha-parsers', '~> 0.7', '>= 0.7.2'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.2'
end
