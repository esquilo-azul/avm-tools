# frozen_string_literal: true

require 'eac_ruby_utils/console/configs'

module Avm
  class << self
    def configs
      @configs ||= ::EacRubyUtils::Console::Configs.new('avm-tools')
    end
  end
end
