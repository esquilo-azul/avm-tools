# frozen_string_literal: true

require 'avm/eac_rails_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        DEFAULT_GEMFILE_PATH = 'PluginGemfile'
        INIT_SUBPATH = 'init.rb'

        # @return [String]
        def default_gemfile_path
          DEFAULT_GEMFILE_PATH
        end

        # @return [String]
        def init_path
          path.join(INIT_SUBPATH)
        end

        # @return [Boolean]
        def valid?
          init_path.exist?
        end
      end
    end
  end
end
