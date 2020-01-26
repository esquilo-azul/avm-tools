# frozen_string_literal: true

require 'avm/self/instance'
require 'eac_ruby_utils/core_ext'

module Avm
  module Docker
    class Registry
      class << self
        def default
          @default ||= new(::Avm::Self.instance.read_entry(
                             ::Avm::Self::Instance::EntryKeys::DOCKER_REGISTRY_NAME
                           ))
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
