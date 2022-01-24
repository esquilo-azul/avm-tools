# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/context'

module EacFs
  class Contexts
    TYPES = %i[cache config data].freeze

    class << self
      TYPES.each do |type|
        class_eval <<~CODE, __FILE__, __LINE__ + 1
          # @return [EacRubyUtils::Context<EacFs::StorageTree>]
          def #{type}
            @#{type} ||= ::EacRubyUtils::Context.new
          end
        CODE
      end
    end
  end
end
