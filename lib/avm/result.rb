# frozen_string_literal: true

require 'colorized_string'
require 'eac_ruby_utils/listable'
require 'eac_ruby_utils/core_ext'

module Avm
  class Result < ::SimpleDelegator
    include ::EacRubyUtils::Listable

    lists.add_string :type, :success, :error, :neutral, :pending, :outdated

    lists.type.values.each do |type| # rubocop:disable Style/HashEachMethods
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def self.#{type}(value)
          new(value, TYPE_#{type.upcase})
        end
      RUBY_EVAL
    end

    TYPE_SUCCESS_COLOR = 'green'
    TYPE_ERROR_COLOR = 'red'
    TYPE_NEUTRAL_COLOR = 'light_black'
    TYPE_PENDING_COLOR = 'yellow'
    TYPE_OUTDATED_COLOR = 'blue'

    class << self
      # Return Avm::Result.success(success_value) if +success+ is truthy.
      # Return Avm::Result.error(error_value || success_value) if +success+ is falsely.
      # @return [Avm::Result]
      def success_or_error(success, success_value, error_value = nil)
        if success
          self.success(success_value)
        else
          error(error_value.presence || success_value)
        end
      end
    end

    attr_reader :type

    def initialize(value, type)
      super(value)
      validate_type(type)
      @type = type
    end

    def label
      label_fg
    end

    def label_fg
      ColorizedString.new(to_s).send(type_color)
    end

    def label_bg
      ColorizedString.new(to_s).light_white.send("on_#{type_color}")
    end

    def type_color
      self.class.const_get("type_#{type}_color".upcase)
    end

    lists.type.values.each do |type| # rubocop:disable Style/HashEachMethods
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{type}?
          @type == '#{type}'
        end
      RUBY_EVAL
    end

    private

    def validate_type(type)
      return if self.class.lists.type.values.include?(type)

      raise "Tipo desconhecido: \"#{type}\" (Válido: #{self.class.lists.type.values.join(', ')})"
    end

    class Error < StandardError
      def to_result
        ::Avm::Result.error(message)
      end
    end
  end
end
