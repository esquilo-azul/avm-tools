# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    module Instances
      class Settings
        DEFAULT_CURRENT_REVISION = 'origin/master'
        DEFAULT_PUBLISH_REMOTE = 'publish'
        PUBLISHABLE_KEY = :publishable

        common_constructor :data do
          self.data = (data.is_a?(Hash) ? data : {}).with_indifferent_access
        end

        def git_current_revision
          data[__method__] || DEFAULT_CURRENT_REVISION
        end

        def git_publish_remote
          data[__method__] || DEFAULT_PUBLISH_REMOTE
        end

        def publishable?
          publishable_value ? true : false
        end

        def stereotype_publishable?(stereotype)
          return publishable? unless publishable_value.is_a?(::Hash)

          parse_publishable_value(publishable_value[stereotype.stereotype_name], true)
        end

        private

        def publishable_value
          parse_publishable_value(data[PUBLISHABLE_KEY], false)
        end

        def parse_publishable_value(value, hash_to_true)
          return value.with_indifferent_access if parse_publishable_value_hash?(value, hash_to_true)
          return true if value.nil? || value == true
          return false if value == false

          value ? true : false
        end

        def parse_publishable_value_hash?(value, hash_to_true)
          !hash_to_true && value.is_a?(::Hash)
        end
      end
    end
  end
end
