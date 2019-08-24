# frozen_string_literal: true

require 'avm/result'

module Avm
  module Git
    module Issue
      class Complete
        def branch
          @git.current_branch
        end

        def branch_hash
          @git.rev_parse("refs/heads/#{branch}")
        end

        def branch_name
          branch.split('/')[-1]
        end

        def branch_name_result
          ::Avm::Result.success_or_error(
            branch_name,
            issue_id || no_avm_branch_name
          )
        end

        def branch_hash_result
          ::Avm::Result.success_or_error(
            branch_hash,
            branch_hash.present?
          )
        end

        def follow_master_result
          return ::Avm::Result.neutral('No branch hash') unless branch_hash

          r = follow_master?
          ::Avm::Result.success_or_error(
            r ? 'yes' : 'no',
            r
          )
        end

        def follow_master?
          remote_master_hash ? @git.descendant?(branch_hash, remote_master_hash) : true
        end

        def remove_local_branch
          info 'Removendo branch local...'
          bn = branch_name
          git(['checkout', branch_hash])
          git(['branch', '-D', bn])
        end
      end
    end
  end
end
