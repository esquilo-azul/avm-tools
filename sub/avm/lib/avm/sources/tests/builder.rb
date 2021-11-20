# frozen_string_literal: true

require 'avm/sources/tests/performer'
require 'avm/sources/tests/single'
require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    module Tests
      class Builder
        require_sub __FILE__
        enable_immutable

        immutable_accessor :include_main, :include_subs, type: :boolean
        immutable_accessor :include_id, type: :array
        common_constructor :main_source

        def immutable_constructor_args
          [main_source]
        end

        # @return [Avm::Sources::Tests::Performer]
        def performer
          ::Avm::Sources::Tests::Performer.new(self)
        end

        def selected_units
          (select_units_from_subs + select_units_from_main + select_units_from_ids).sort.uniq
        end

        private

        # @return [Array<Avm::Sources::Tests::Single>]
        def available_units
          @available_units ||= ([main_source] + main_source.subs)
                               .map { |a_source| create_unit(a_source) }
        end

        def available_units_from_main
          create_units([main_source])
        end

        def available_units_from_subs
          create_units(main_source.subs)
        end

        # @return [Avm::Sources::Tests::Single]
        def create_unit(source)
          ::Avm::Sources::Tests::Single.new(self, source)
        end

        # @return [Array<Avm::Sources::Tests::Single>]
        def create_units(sources)
          sources.map { |a_source| create_unit(a_source) }
        end

        # @return [Avm::Sources::Tests::Single]
        def create_unit_by_id(source_id)
          r = available_units.find { |unit| unit.id == source_id }
          return r if r

          raise ::ArgumentError, "Source not found with ID=#{source_id}" \
            "(Available: #{available_units.map(&:id).join(', ')})"
        end

        # @return [Array<Avm::Sources::Tests::Single>]
        def select_units_from_ids
          include_ids.map { |source_id| create_unit_by_id(source_id) }
        end

        # @return [Array<Avm::Sources::Tests::Single>]
        def select_units_from_main
          include_main? ? available_units_from_main : []
        end

        # @return [Array<Avm::Sources::Tests::Single>]
        def select_units_from_subs
          include_subs? ? available_units_from_subs : []
        end
      end
    end
  end
end
