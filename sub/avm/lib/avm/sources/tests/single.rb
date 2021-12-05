# frozen_string_literal: true

require 'avm/sources/tests/result'
require 'eac_ruby_utils/core_ext'
require 'eac_fs/logs'

module Avm
  module Sources
    module Tests
      class Single
        MAIN_SOURCE_ID = '#main'

        compare_by :order_group, :id
        enable_simple_cache
        enable_speaker

        common_constructor :builder, :source

        delegate :logs, :result, to: :tester
        delegate :to_s, to: :id

        def failed?
          result == ::Avm::Sources::Tests::Result::FAILED
        end

        # @return [String]
        def id
          if main?
            MAIN_SOURCE_ID
          else
            relative_path_from_main_source.to_s
          end
        end

        def main?
          relative_path_from_main_source.to_s == '.'
        end

        def order_group
          main? ? 1 : 0
        end

        # @return [Pathname]
        def relative_path_from_main_source
          source.path.relative_path_from(builder.main_source.path)
        end

        private

        def tester_uncached
          source.tester
        end
      end
    end
  end
end
