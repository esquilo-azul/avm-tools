# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/apps/version'

Gem::Specification.new do |s|
  s.name        = 'avm-apps'
  s.version     = Avm::Apps::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'DEPRECATED: use gem "avm" instead.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.67'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.2'
end
