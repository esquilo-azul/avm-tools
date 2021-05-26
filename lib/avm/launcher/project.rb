# frozen_string_literal: true

module Avm
  module Launcher
    class Project
      attr_reader :name, :instances

      def initialize(name, instances)
        @name = name
        @instances = instances.to_a
      end

      def to_s
        name
      end
    end
  end
end
