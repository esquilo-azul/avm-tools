# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module Entries
      class EntryReader
        common_constructor :parent, :suffix, :options

        def full_path
          (parent.path_prefix + suffix_as_array).join('.')
        end

        def read(extra_options = {})
          ::Avm.configs.read_entry(full_path, options.merge(extra_options))
        end

        def suffix_as_array
          if suffix.is_a?(::Array)
            suffix.dup
          else
            ::EacRubyUtils::PathsHash.parse_entry_key(suffix.to_s)
          end
        end

        def value
          read
        end
      end
    end
  end
end
