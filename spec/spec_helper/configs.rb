# frozen_string_literal: true

require 'avm/configs'
require 'tempfile'

temp_file = ::Tempfile.new('avm-tools_rspec_storage')
temp_storage_path = temp_file.path
temp_file.close

RSpec.configure do |config|
  config.before do
    ::Avm.configs_storage_path = temp_storage_path
  end

  config.after do
    ::File.unlink(temp_storage_path) if ::File.exist?(temp_storage_path)
  end
end
