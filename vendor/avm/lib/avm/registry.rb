# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/gems_registry'

module Avm
  module Registry
    require_sub __FILE__
    enable_listable
    lists.add_symbol :category, :instance_stereotypes, :scms, :source_stereotypes

    class << self
      enable_simple_cache

      # @return [Array<Avm::Registry::Base>]
      def registries
        lists.category.values.map { |c| send(c) }
      end

      private

      ::Avm::Registry.lists.category.each_value do |category|
        define_method "#{category}_uncached" do
          ::Avm::Registry::Base.new(category.to_s.camelize)
        end
      end
    end
  end
end
