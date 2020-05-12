# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_launcher/git/remote'

module EacLauncher
  module Git
    class Base < ::EacLauncher::Paths::Real
      # @return [EacLauncher::Git::Remote]
      def remote(name)
        ::EacLauncher::Git::Remote.new(self, name)
      end

      def remote_hashs(remote_name)
        remote(remote_name).ls
      end

      def remote_exist?(remote_name)
        remote(remote_name).exist?
      end

      def assert_remote_url(remote_name, url)
        r = git.remote(remote_name)
        if !r.url || r.url != url
          r.remove if r.url
          git.add_remote(remote_name, url)
        end
        r
      end

      def remote_branch_sha(remote_name, branch_name)
        remote_hashs(remote_name)["refs/heads/#{branch_name}"]
      end
    end
  end
end
