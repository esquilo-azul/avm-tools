# frozen_string_literal: true

require 'avm/tools/self'
require 'i18n'

module Avm
  module Patches
    module I18n
      class << self
        def setup_i18n
          ::I18n.load_path += locale_files_paths.map(&:to_path)
        end

        def locale_files_paths
          ::Avm::Tools::Self.root.join('locale').glob('*.yml')
        end
      end
    end
  end
end

::Avm::Patches::I18n.setup_i18n
