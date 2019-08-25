# frozen_string_literal: true

require 'avm/result'

module Avm
  module Git
    module Issue
      class Complete
        def commits_result
          ::Avm::Result.success_or_error(
            commits.any? ? 'yes' : 'none',
            commits.any?
          )
        end

        def commits_uncached
          return [] unless branch_hash && follow_master?

          interval = remote_master_hash ? "#{remote_master_hash}..#{branch_hash}" : branch_hash
          @git.execute!('rev-list', interval).each_line.map(&:strip)
        end
      end
    end
  end
end
