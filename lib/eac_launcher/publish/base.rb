# frozen_string_literal: true

require 'eac_launcher/instances/error'

module EacLauncher
  module Publish
    class Base
      attr_reader :instance

      def initialize(instance)
        @instance = instance
      end

      def run
        s = check
        info("Check: #{s}")
        return unless s.status == ::EacLauncher::Publish::CheckResult::STATUS_PENDING

        publish
      end

      def check
        s = check_with_rescue
        ::EacLauncher::Context.current.instance_manager.publish_state_set(
          instance, stereotype.stereotype_name, s.status
        )
        s
      end

      private

      def stereotype
        self.class.name.deconstantize.constantize
      end

      def check_with_rescue
        internal_check
      rescue ::EacLauncher::Instances::Error => e
        ::EacLauncher::Publish::CheckResult.blocked("Error: #{e}")
      rescue ::EacLauncher::Git::Error => e
        ::EacLauncher::Publish::CheckResult.blocked("Git error: #{e}")
      end
    end
  end
end
