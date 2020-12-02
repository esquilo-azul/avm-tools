# frozen_string_literal: true

require 'eac_ruby_utils/console/configs/entry_reader'

module EacRubyUtils
  module Console
    class Configs
      class StorePasswordsEntryReader < ::EacRubyUtils::Console::Configs::EntryReader
        ENTRY_KEY = 'core.store_passwords'

        def initialize(console_configs)
          super(console_configs, ENTRY_KEY,
            before_input: -> { banner },
            validator: ->(entry_value) { %w[yes no].include?(entry_value) }
          )
        end

        def banner
          infom 'Do you wanna to store passwords?'
          infom 'Warning: the passwords will be store in clear text in ' \
            "\"#{console_configs.configs.storage_path}\""
          infom 'Enter "yes" or "no"'
        end
      end
    end
  end
end
