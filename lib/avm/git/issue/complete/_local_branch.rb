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

        def branch_valid?
          issue_id || options[:no_avm_branch_name]
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
