# frozen_string_literal: true

require 'eac_launcher/git/base'

module EacLauncher
  module Git
    class MirrorUpdate < ::EacLauncher::Paths::Real
      include ::EacRubyUtils::SimpleCache

      def initialize(target_path, source_path, source_rev)
        super(target_path)
        @target_git = ::EacLauncher::Git::Base.new(self)
        @source_git = ::EacLauncher::Git::Base.new(source_path)
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
