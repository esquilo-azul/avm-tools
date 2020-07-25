# frozen_string_literal: true

require 'eac_launcher/instances/error'

module EacLauncher
  module Git
    module SubWarpBase
      private

      def parent_instance_uncached
        r = find_parent_instance(instance.parent)
        return r if r

        ::EacLauncher::Instances::Error.new('Git parent not found')
      end

      def find_parent_instance(current)
        if ::Avm::Projects::Stereotype.git_stereotypes.any? { |s| current.stereotype?(s) }
          return current
        end

        current.parent ? find_parent_instance(current.parent) : nil
      end

      def to_parent_git_path
        instance.logical.gsub(%r{\A#{Regexp.quote(parent_instance.logical)}/}, '')
      end
    end
  end
end
