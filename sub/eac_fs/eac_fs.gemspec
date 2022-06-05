# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_fs/version'

Gem::Specification.new do |s|
  s.name        = 'eac_fs'
  s.version     = EacFs::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'content-type'
  s.add_dependency 'eac_ruby_utils', '~> 0.70'
  s.add_dependency 'ruby-filemagic'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
