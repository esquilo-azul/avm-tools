# frozen_string_literal: true

require 'avm/scms/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class Null < ::Avm::Scms::Base
      def update
        # Do nothing
      end
    end
  end
end
