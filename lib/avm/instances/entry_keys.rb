# frozen_string_literal: true

module Avm
  module Instances
    module EntryKeys
      class << self
        def keys_consts_set(prefix, suffixes)
          if suffixes.is_a?(::Hash)
            keys_consts_set_from_hash(prefix, suffixes)
          elsif suffixes.is_a?(::Enumerable)
            keys_consts_set_from_enum(prefix, suffixes)
          else
            raise "Unmapped suffixes class: #{suffixes.class}"
          end
        end

        def key_const_set(prefix, suffix)
          key = [prefix, suffix].reject(&:blank?).join('.')
          const_set(key.gsub('.', '_').upcase, key)
        end

        private

        def keys_consts_set_from_enum(prefix, suffixes)
          suffixes.each { |suffix| key_const_set(prefix, suffix) }
        end

        def keys_consts_set_from_hash(prefix, suffixes)
          suffixes.each { |k, v| keys_consts_set(prefix.to_s + (k.blank? ? '' : ".#{k}"), v) }
        end
      end

      {
        '' => %w[fs_path],
        database: %w[id hostname name password port system username],
        web: %w[authority hostname path port scheme url userinfo]
      }.each { |prefix, suffixes| keys_consts_set(prefix, suffixes) }
    end
  end
end
