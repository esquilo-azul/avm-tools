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
    end
  end
end
