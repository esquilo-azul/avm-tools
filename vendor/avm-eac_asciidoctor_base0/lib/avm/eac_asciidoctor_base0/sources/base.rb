# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base
        common_constructor :root do
          self.root = root.to_pathname
        end
      end
    end
  end
end
