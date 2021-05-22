# frozen_string_literal: true

require 'avm/patches/eac_ruby_gems_utils/gem'
require 'i18n'

module Avm
  module Apps
    module Sources
      class Configuration < ::EacConfig::OldConfigs
        LOCALE_KEY = :locale

        def locale
          read_entry(LOCALE_KEY) || ::I18n.default_locale
        end
      end
    end
  end
end
