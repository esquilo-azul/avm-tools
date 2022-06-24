# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_rails_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_rails_base0'
  s.version     = Avm::EacRailsBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*']

  s.add_dependency 'avm-eac_rails_base1', '~> 0.3'
  s.add_dependency 'eac_ruby_utils', '~> 0.80', '>= 0.80.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.4'
end
