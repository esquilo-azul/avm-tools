# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_ruby_base0/version'

Gem::Specification.new do |s|
  s.name        = 'eac_ruby_base0'
  s.version     = EacRubyBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_cli', '~> 0.26'
  s.add_dependency 'eac_fs', '~> 0.10'
  s.add_dependency 'eac_ruby_gems_utils', '~> 0.9', '~> 0.9.6'
  s.add_dependency 'eac_ruby_utils', '~> 0.95', '>= 0.95.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
