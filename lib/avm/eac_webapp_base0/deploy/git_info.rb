# frozen_string_literal: true

module Avm
  module EacWebappBase0
    class Deploy
      module GitInfo
        def commit_sha1_uncached
          git_fetch
          r = git.rev_parse(git_reference_found)
          return r if r

          raise ::Avm::Result::Error, "No commit SHA1 found for \"#{git_reference_found}\""
        end

        def git_reference
          options[:reference] || DEFAULT_REFERENCE
        end

        def git_reference_found_uncached
          %w[git_reference instance_branch master_branch].map { |b| send(b) }.find(&:present?) ||
            raise(
              ::Avm::Result::Error,
              'No git reference found (Searched for option, instance and master)'
            )
        end

        def git_remote_hashs_uncached
          git.remote_hashs(git_remote_name)
        end

        def git_remote_name
          ::Avm::Git::DEFAULT_REMOTE_NAME
        end

        def instance_branch
          remote_branch(instance.id)
        end

        def remote_branch(name)
          git_remote_hashs.key?("refs/heads/#{name}") ? "#{git_remote_name}/#{name}" : nil
        end

        def master_branch
          remote_branch('master')
        end
      end
    end
  end
end
