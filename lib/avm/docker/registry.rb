# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Docker
    class Registry
      class << self
        def default
          @default ||= new(::Avm.configs.read_entry('self.docker.registry.name'))
        end
      end

      common_constructor :name

      def to_s
        name
      end

      def sub(suffix)
        self.class.new("#{name}#{suffix}")
      end
    end
  end
end
