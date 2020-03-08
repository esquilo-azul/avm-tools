# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __dir__)
require 'tmpdir'
require 'eac_ruby_utils/core_ext'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ::File.join(::Dir.tmpdir, 'avm-tools_rspec')
end

APP_ROOT = ::File.expand_path('..', __dir__)
require 'aranha/parsers/spec/source_target_fixtures_example'
::EacRubyUtils.require_sub(__FILE__)
