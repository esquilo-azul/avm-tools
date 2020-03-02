# frozen_string_literal: true

module Avm
  module Ruby
    class << self
      def on_clean_environment
        on_clean_envvars('BUNDLE', 'RUBY') { yield }
      end

      private

      def on_clean_envvars(*start_with_vars)
        old_values = envvars_starting_with(start_with_vars)
        old_values.keys.each { |k| ENV.delete(k) } # rubocop:disable Style/HashEachMethods
        yield
      ensure
        old_values&.each { |k, v| ENV[k] = v }
      end

      def envvars_starting_with(start_with_vars)
        ENV.select { |k, _v| start_with_vars.any? { |var| k.start_with?(var) } }
      end
    end
  end
end
