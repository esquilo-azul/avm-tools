# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'
require 'eac_ruby_utils/simple_cache'
require 'eac_launcher/publish/base'

module EacLauncher
  module Git
    class PublishBase < ::EacLauncher::Publish::Base
      include ::EacRubyUtils::SimpleCache
      include ::EacRubyUtils::Console::Speaker

      CHECKERS = %w[remote_url remote_fetch publish_remote_no_exist remote_equal remote_following
                    local_following].freeze

      REMOTE_UNAVAILABLE_MESSAGES = ['could not resolve host', 'connection timed out',
                                     'no route to host'].map(&:downcase).freeze

      protected

      def internal_check
        CHECKERS.each do |checker|
          result = send("#{checker}_check_result")
          return result if result
        end
        divergent_result_check_result
      rescue ::StandardError => e
        raise e unless remote_unavailable_error?(e)

        ::EacLauncher::Publish::CheckResult.blocked(e.message)
      end

      private

      def remote_url_check_result
        remote = sgit.remote(remote_name)
        return if remote.exist? && remote.url.present?

        ::EacLauncher::Publish::CheckResult.blocked("Remote \"#{remote_name}\" has blank path")
      end

      def remote_fetch_check_result
        remote_fetch
        nil
      end

      def remote_unavailable_error?(error)
        error_message = error.message.downcase
        REMOTE_UNAVAILABLE_MESSAGES.any? do |message|
          error_message.include?(message)
        end
      end

      def publish_remote_no_exist_check_result
        return nil if sgit.remote_exist?(remote_name)

        ::EacLauncher::Publish::CheckResult.blocked('Remote does not exist')
      end

      def remote_equal_check_result
        return nil unless remote_sha.present? && remote_sha == local_sha

        ::EacLauncher::Publish::CheckResult.updated('Remote equal')
      end

      def remote_following_check_result
        return nil unless remote_sha.present? && sgit.descendant?(remote_sha, local_sha)

        ::EacLauncher::Publish::CheckResult.outdated('Remote following')
      end

      def divergent_result_check_result
        ::EacLauncher::Publish::CheckResult.blocked(
          "Divergent (L: #{local_sha}, R: #{remote_sha})"
        )
      end

      def local_following?
        return true if remote_sha.blank?

        sgit.descendant?(local_sha, remote_sha)
      end

      def local_following_check_result
        ::EacLauncher::Publish::CheckResult.pending('Local following')
      end

      def sgit_uncached
        ::EacLauncher::Git::Base.new(instance.warped)
      end

      def publish
        info 'Pushing...'
        sgit.push(remote_name, 'HEAD:master',
                  dryrun: !::EacLauncher::Context.current.publish_options[:confirm])
        info 'Pushed!'
      end

      def local_sha
        sgit.git.object('HEAD').sha
      end

      def remote_sha_uncached
        remote_fetch
        b = sgit.git.branches["#{remote_name}/master"]
        b ? b.gcommit.sha : nil
      end

      def remote_fetch_uncached
        sgit.fetch(remote_name)
      end

      def remote_name
        ::EacLauncher::Git::WarpBase::TARGET_REMOTE
      end
    end
  end
end
