# frozen_string_literal: true

require 'active_support/concern' # Missing on "eac/listable"
require 'active_support/hash_with_indifferent_access'
require 'eac_ruby_utils/listable'

module Avm
  module Launcher
    module Publish
      class CheckResult
        include ::EacRubyUtils::Listable

        lists.add_string :status, :updated, :pending, :blocked, :outdated

        lists.status.values.each do |status| # rubocop:disable Style/HashEachMethods
          class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def self.#{status}(message)
            new('#{status}', message)
          end
          RUBY_EVAL
        end

        class << self
          def pending_status?(status)
            [STATUS_PENDING].include?(status)
          end

          def updated_color
            'green'
          end

          def pending_color
            'yellow'
          end

          def blocked_color
            'red'
          end

          def outdated_color
            'light_blue'
          end
        end

        attr_reader :status, :message

        def initialize(status, message)
          raise "Status \"#{status}\" not in #{self.class.lists.status.values}" unless
          self.class.lists.status.values.include?(status)

          @status = status
          @message = message
        end

        def to_s
          message.light_white.send("on_#{background_color}")
        end

        private

        def background_color
          self.class.send("#{status}_color")
        end
      end
    end
  end
end
