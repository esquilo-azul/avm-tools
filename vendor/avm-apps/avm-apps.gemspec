# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/apps/version'

Gem::Specification.new do |s|
  s.name        = 'avm-apps'
  s.version     = Avm::Apps::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'AVM components for applications.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.58', '>= 0.58.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1', '>= 0.1.2'
end
