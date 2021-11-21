# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Testing
        delegate :tester, to: :stereotype
      end
    end
  end
end
