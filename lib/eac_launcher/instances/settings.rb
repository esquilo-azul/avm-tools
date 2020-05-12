# frozen_string_literal: true

module EacLauncher
  module Instances
    class Settings
      def initialize(data)
        @data = ActiveSupport::HashWithIndifferentAccess.new(data.is_a?(Hash) ? data : {})
      end

      def git_current_revision
        @data[__method__] || 'origin/master'
      end

      def git_publish_remote
        @data[__method__] || 'publish'
      end

      def publishable?
        @data.key?(:publishable) ? @data[:publishable] : true
      end
    end
  end
end
