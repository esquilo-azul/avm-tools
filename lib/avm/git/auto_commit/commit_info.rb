# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Git
    module AutoCommit
      class CommitInfo
        enable_immutable

        immutable_accessor :fixup

        def git_commit_args
          r = fixup.if_present([]) { |v| ['--fixup', v.sha1] }
          return r if r.any?

          raise 'Argument list is empty'
        end
      end
    end
  end
end
