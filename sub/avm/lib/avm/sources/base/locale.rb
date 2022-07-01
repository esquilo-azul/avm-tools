# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'i18n'

module Avm
  module Sources
    class Base
      module Locale
        LOCALE_KEY = 'locale'

        def locale
          configured_locale || default_locale
        end

        def configured_locale
          configuration.entry(LOCALE_KEY).value
        end

        def default_locale
          ::I18n.default_locale
        end
      end
    end
  end
end
