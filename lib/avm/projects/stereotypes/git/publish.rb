# frozen_string_literal: true

require 'avm/launcher/git/publish_base'

module Avm
  module Projects
    module Stereotypes
      class Git
        class Publish < ::Avm::Launcher::Git::PublishBase
          PUBLISH_GIT_REMOTE_NAME = 'publish'
        end
      end
    end
  end
end
