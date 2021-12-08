# frozen_string_literal: true

require 'avm/instances/entries'

module Avm
  module Instances
    class Application
      include ::Avm::Instances::Entries

      attr_reader :id

      def initialize(id)
        @id = id.to_s
      end

      def to_s
        id
      end

      def instance(suffix)
        ::Avm::Instances::Base.new(self, suffix)
      end

      def name
        entry(::Avm::Instances::EntryKeys::NAME).read
      end
    end
  end
end
