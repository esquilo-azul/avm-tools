# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_ruby_base0/version'

Gem::Specification.new do |s|
  s.name        = 'eac_ruby_base0'
  s.version     = EacRubyBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_cli', '~> 0.15', '>= 0.15.1'
  s.add_dependency 'eac_ruby_gems_utils', '~> 0.8'
  s.add_dependency 'eac_ruby_utils', '~> 0.60'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1', '>= 0.1.2'
end
