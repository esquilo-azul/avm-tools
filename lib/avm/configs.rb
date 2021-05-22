# frozen_string_literal: true

require 'eac_cli/old_configs_bridge'

module Avm
  class << self
    attr_reader :configs_storage_path

    def configs
      @configs ||= ::EacCli::OldConfigsBridge.new('avm-tools', configs_options)
    end

    def configs_file_path
      configs_storage_path || default_configs_file_path
    end

    def configs_options
      configs_storage_path.if_present({}) { |v| { storage_path: v } }
    end

    def configs_storage_path=(path)
      @configs_storage_path = path
      @configs = nil
    end
  end
end
