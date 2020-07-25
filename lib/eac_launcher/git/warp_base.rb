# frozen_string_literal: true

require 'eac_launcher/git/mirror_update'
require 'eac_launcher/vendor/github'
require 'avm/projects/stereotypes/git/publish'

module EacLauncher
  module Git
    # Métodos abstratos:
    #  * source_instance
    #  * source_remote_name
    #  * current_ref
    class WarpBase < ::EacLauncher::Paths::Real
      include ::EacRubyUtils::SimpleCache

      TARGET_REMOTE = ::Avm::Projects::Stereotypes::Git::Publish::PUBLISH_GIT_REMOTE_NAME

      def initialize(instance)
        @instance = instance
        cache_git.git.reset_hard(current_ref)
        cache_git.remote(TARGET_REMOTE).url = target_remote_url
        super(path)
      end

      protected

      attr_reader :instance

      def update
        ::EacLauncher::Git::MirrorUpdate.new(
          path,
          source_instance.real,
          source_instance.options.git_current_revision
        )
      end

      def path
        instance.cache_path('git_repository')
      end

      def source_git_uncached
        ::EacLauncher::Git::Base.new(source_instance.real)
      end

      def cache_git_uncached
        ::EacLauncher::Git::Base.new(update)
      end

      def target_remote_url
        ::EacLauncher::Vendor::Github.to_ssh_url(source_git.git.remote(source_remote_name).url)
      end
    end
  end
end
