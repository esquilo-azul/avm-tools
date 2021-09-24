# frozen_string_literal: true

require 'avm/self'
require 'eac_cli/old_configs_bridge'
require 'tempfile'

temp_file = ::Tempfile.new('avm-tools_rspec_storage')
temp_storage_path = temp_file.path
temp_file.close

RSpec.configure do |config|
  config.around do |example|
    temp_config(temp_storage_path) { example.run }
    ::File.unlink(temp_storage_path) if ::File.exist?(temp_storage_path)
  end

  def temp_config(path, &block)
    r = ::Avm::Self.build_config(path)
    ::EacConfig::Node.context.on(r, &block) if block
    r
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
