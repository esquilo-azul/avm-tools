# frozen_string_literal: true

require 'pathname'

module Avm
  module Self
    class << self
      def root
        ::Pathname.new('../../..').expand_path(__dir__)
      end
    end
  end
end
