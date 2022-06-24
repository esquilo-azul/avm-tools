# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRailsBase1
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        CONFIG_RU_SUBPATH = 'config.ru'
        SUBS_PATHS_DEFAULT = ['sub/*/*'].freeze

        def config_ru_path
          path.join(CONFIG_RU_SUBPATH)
        end

        def subs_paths_default
          SUBS_PATHS_DEFAULT
        end

        def valid?
          super && config_ru_path.exist?
        end
      end
    end
  end
end
