# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'
require 'avm/instances/entries'

module Avm
  module Instances
    class Base
      include ::EacRubyUtils::SimpleCache
      include ::Avm::Instances::Entries

      ID_PATTERN = /\A([a-z]+(?:\-[a-z]+)*)_(.+)\z/.freeze

      class << self
        def by_id(id)
          application_id, suffix = parse_id(id)
          require 'avm/instances/application'
          new(::Avm::Instances::Application.new(application_id), suffix)
        end

        private

        def parse_id(id)
          m = ID_PATTERN.match(id)
          return [m[1], m[2]] if m

          raise "ID Pattern no matched: \"#{id}\""
        end
      end

      attr_reader :application, :suffix

      def initialize(application, suffix)
        @application = application
        @suffix = suffix.to_s
      end

      def id
        "#{application.id}_#{suffix}"
      end

      def host_env_uncached
        if read_entry('host') == 'localhost'
          ::EacRubyUtils::Envs.local
        else
          ::EacRubyUtils::Envs.ssh("#{read_entry('user')}@#{read_entry('host')}")
        end
      end
    end
  end
end
