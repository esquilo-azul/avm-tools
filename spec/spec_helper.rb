# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __dir__)
require 'tmpdir'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ::File.join(::Dir.tmpdir, 'avm-tools_rspec')
end

require 'aranha/parsers/spec/source_target_fixtures_example'
