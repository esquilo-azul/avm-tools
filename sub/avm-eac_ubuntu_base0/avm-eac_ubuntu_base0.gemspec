# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_ubuntu_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_ubuntu_base0'
  s.version     = Avm::EacUbuntuBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*']

  s.add_dependency 'avm', '~> 0.7'
  s.add_dependency 'eac_ruby_utils', '~> 0.77', '>= 0.77.1'
  s.add_dependency 'eac_templates', '~> 0.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.4'
end
