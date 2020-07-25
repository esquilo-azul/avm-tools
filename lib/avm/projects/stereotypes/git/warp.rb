# frozen_string_literal: true

require 'eac_launcher/git/warp_base'

module Avm
  module Projects
    module Stereotypes
      class Git
        class Warp < ::EacLauncher::Git::WarpBase
          private

          def current_ref
            'HEAD'
          end

          def source_instance
            instance
          end

          def source_remote_name
            ::Avm::Projects::Stereotypes::Git::Publish::PUBLISH_GIT_REMOTE_NAME
          end
        end
      end
    end
  end
end