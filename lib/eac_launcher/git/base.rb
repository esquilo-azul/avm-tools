# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'
require 'eac_ruby_utils/envs'
require 'eac_launcher/paths/real'
require 'eac_launcher/git/base/underlying'
require 'eac_launcher/git/base/subrepo'
require 'eac_launcher/git/error'

module EacLauncher
  module Git
    class Base < ::EacLauncher::Paths::Real
      include ::EacRubyUtils::SimpleCache
      include ::EacLauncher::Git::Base::Subrepo
      include ::EacLauncher::Git::Base::Underlying
      require_relative ::File.join(__dir__, 'base', '_remotes')

      def init_bare
        FileUtils.mkdir_p(self)
        ::EacRubyUtils::Envs.local.command('git', 'init', '--bare', self).execute! unless
        File.exist?(subpath('.git'))
      end

      def rev_parse(ref, required = false)
        r = execute!('rev-parse', ref, exit_outputs: { 128 => nil, 32_768 => nil })
        r.strip! if r.is_a?(String)
        return r if r.present?
        return nil unless required

        raise "Reference \"#{ref}\" not found"
      end

      def descendant?(descendant, ancestor)
        base = merge_base(descendant, ancestor)
        return false if base.blank?

        revparse = execute!('rev-parse', '--verify', ancestor).strip
        base == revparse
      end

      def merge_base(*commits)
        refs = commits.dup
        while refs.count > 1
          refs[1] = merge_base_pair(refs[0], refs[1])
          return nil if refs[1].blank?

          refs.shift
        end
        refs.first
      end

      def subtree_split(prefix)
        execute!('subtree', '-q', 'split', '-P', prefix).strip
      end

      def push(remote_name, refspecs, options = {})
        refspecs = [refspecs] unless refspecs.is_a?(Array)
        args = ['push']
        args << '--dry-run' if options[:dryrun]
        args << '--force' if options[:force]
        system!(args + [remote_name] + refspecs)
      end

      def push_all(remote_name)
        system!('push', '--all', remote_name)
        system!('push', '--tags', remote_name)
      end

      def fetch(remote_name, options = {})
        args = ['fetch', '-p', remote_name]
        args += %w[--tags --prune-tags --force] if options[:tags]
        execute!(*args)
      end

      def current_branch
        execute!(%w[symbolic-ref -q HEAD]).gsub(%r{\Arefs/heads/}, '').strip
      end

      def reset_hard(ref)
        execute!('reset', '--hard', ref)
      end

      def raise(message)
        ::Kernel.raise EacLauncher::Git::Error.new(self, message)
      end

      private

      def merge_base_pair(commit1, commit2)
        execute!('merge-base', commit1, commit2, exit_outputs: { 256 => '' }).strip
      end
    end
  end
end
