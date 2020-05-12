# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'
require 'eac_launcher/git/sub_warp_base'
require 'eac_launcher/instances/error'
require 'eac_launcher/paths/real'
require 'eac_launcher/vendor/github'

module EacLauncher
  module Stereotypes
    class GitSubrepo
      class Warp < ::EacLauncher::Paths::Real
        include ::EacLauncher::Git::SubWarpBase
        include ::EacRubyUtils::SimpleCache

        attr_reader :instance

        def initialize(instance)
          @instance = instance
          check_parent
          init_aux
          push_to_aux
          reset
          assert_target_remote
          super(warped_git)
        end

        private

        def check_parent
          return if parent_git_warped.rev_parse(subrepo_parent_hash) &&
                    parent_git_warped.descendant?('HEAD', subrepo_parent_hash)

          raise EacLauncher::Instances::Error, "Subrepo parent hash \"#{subrepo_parent_hash}\""\
            " not found in \"#{parent_git_warped}\""
        end

        def subrepo_parent_hash
          data = parent_git_warped.subrepo_status(to_parent_git_path)
          h = data['Pull Parent']
          return h if h.present?

          raise EacLauncher::Instances::Error, "Subrepo parent hash is blank: #{data}"
        end

        def init_aux
          ::EacLauncher::Git::Base.new(aux_path).init_bare
        end

        def parent_git_warped_uncached
          ::EacLauncher::Git::Base.new(parent_instance.warped)
        end

        def aux_path
          instance.cache_path('subrepo_aux_git_repository')
        end

        def warped_git_uncached
          ::EacLauncher::Git::Base.new(instance.cache_path('git_repository'))
        end

        def push_to_aux
          parent_git_warped.execute!('subrepo', 'branch', to_parent_git_path, '-fF')
          h = parent_git_warped.rev_parse("subrepo/#{to_parent_git_path}", true)
          parent_git_warped.execute!('push', aux_path, "#{h}:refs/heads/master", '--force')
        end

        def reset
          ::EacLauncher::Git::MirrorUpdate.new(warped_git, aux_path, 'master')
        end

        def assert_target_remote
          warped_git.assert_remote_url(::EacLauncher::Git::WarpBase::TARGET_REMOTE,
                                       target_remote_url)
        end

        def target_remote_url
          ::EacLauncher::Vendor::Github.to_ssh_url(
            parent_git_warped.subrepo_remote_url(to_parent_git_path)
          )
        end
      end
    end
  end
end
