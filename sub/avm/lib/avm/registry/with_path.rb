# frozen_string_literal: true

require 'avm/registry/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class WithPath < ::Avm::Registry::Base
      def detect_by_path(path)
        detect_by_path_optional(path) || raise_not_found(path)
      end

      def detect_by_path_optional(path)
        current_path = path.to_pathname.expand_path
        until current_path.root?
          detect_optional(current_path).if_present { |v| return v }
          current_path = current_path.parent
        end
        nil
      end
    end
  end
end
