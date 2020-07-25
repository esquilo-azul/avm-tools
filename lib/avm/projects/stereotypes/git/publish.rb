# frozen_string_literal: true

require 'eac_launcher/git/publish_base'

module Avm
  module Projects
    module Stereotypes
      class Git
        class Publish < ::EacLauncher::Git::PublishBase
          PUBLISH_GIT_REMOTE_NAME = 'publish'
        end
      end
    end
  end
end
