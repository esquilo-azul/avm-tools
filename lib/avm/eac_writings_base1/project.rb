# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWritingsBase1
    class Project
      common_constructor :root do
        self.root = root.to_pathname
      end
    end
  end
end
