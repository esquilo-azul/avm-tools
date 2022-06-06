# frozen_string_literal: true

require 'avm/projects/stereotype'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      require_sub __FILE__, base: nil

      class << self
        def list
          @list ||= constants.map { |c| const_get(c) }
                      .select { |c| c.included_modules.include?(Avm::Projects::Stereotype) }
                      .freeze
        end
      end
    end
  end
end
