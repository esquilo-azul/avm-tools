# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base < ::Avm::EacWebappBase0::Sources::Base
        def valid?
          false
        end
      end
    end
  end
end
