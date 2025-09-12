# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__ do
  ignore 'core_ext'
end

module Avm
  module Tools
  end
end

require 'avm'
require 'eac_ruby_base0'

require 'avm/tools/core_ext'
