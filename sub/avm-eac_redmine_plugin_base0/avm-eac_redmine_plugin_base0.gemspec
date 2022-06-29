# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_redmine_plugin_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_redmine_plugin_base0'
  s.version     = Avm::EacRedminePluginBase0::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'E.A.C.\'s AVM base for Redmine plugins.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.95', '>= 0.95.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5', '>= 0.5.1'
end
