# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'
require 'eac_ruby_utils/simple_cache'
require 'avm/instances/entries'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      enable_listable
      enable_simple_cache
      require_sub __FILE__, include_modules: true
      include ::Avm::Instances::Entries

      lists.add_string :access, :local, :ssh

      ID_PATTERN = /\A([a-z0-9]+(?:\-[a-z0-9]+)*)_(.+)\z/.freeze

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

      common_constructor :application, :suffix do
        self.suffix = suffix.to_s
      end

      def id
        "#{application.id}_#{suffix}"
      end

      def to_s
        id
      end

      def host_env_uncached
        access = read_entry(:access, list: ::Avm::Instances::Base.lists.access.values)
        case access
        when 'local' then ::EacRubyUtils::Envs.local
        when 'ssh' then ::EacRubyUtils::Envs.ssh(read_entry('ssh.url'))
        else raise("Unmapped access value: \"#{access}\"")
        end
      end

      private

      def source_instance_uncached
        ::Avm::Instances::Base.by_id(read_entry(::Avm::Instances::EntryKeys::SOURCE_INSTANCE_ID))
      end
    end
  end
end
