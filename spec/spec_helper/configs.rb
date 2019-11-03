# frozen_string_literal: true

require 'eac_ruby_utils/console/configs'
require 'tempfile'
require 'avm/configs'

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

module EacRubyUtils
  module Console
    class Configs
      protected

      def read_entry_from_console(entry_key, _options)
        raise "Console input requested for entry \"#{entry_key}\""
      end
    end
  end
end
