# frozen_string_literal: true

require 'avm/launcher/git/base'

module Avm
  module Launcher
    module Git
      class MirrorUpdate < ::Avm::Launcher::Paths::Real
        include ::EacRubyUtils::SimpleCache

        def initialize(target_path, source_path, source_rev)
          super(target_path)
          @target_git = ::Avm::Launcher::Git::Base.new(self)
          @source_git = ::Avm::Launcher::Git::Base.new(source_path)
          @source_rev = source_rev
          run
        end

        private

        def run
          fetch_remote_source
          reset_source_rev
        end

        def fetch_remote_source
          @target_git.git
          @target_git.assert_remote_url('origin', @source_git)
          @target_git.fetch('origin', tags: true)
        end

        def reset_source_rev
          @target_git.reset_hard(@source_git.rev_parse(@source_rev, true))
        end
      end
    end
  end
end
