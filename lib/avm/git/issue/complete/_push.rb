# frozen_string_literal: true

module Avm
  module Git
    module Issue
      class Complete
        def push
          if pushs.empty?
            info 'PUSH: Nada a enviar'
          else
            info "PUSH: enviando \"#{pushs}\"..."
            git(%w[push origin] + pushs)
          end
        end

        def pushs_uncached
          [master_push, remove_branch_push, tag_push].reject(&:nil?)
        end

        def master_push
          remote_master_hash != branch_hash ? "#{branch_hash}:refs/heads/master" : nil
        end

        def remove_branch_push
          remote_branch_hash ? ":refs/heads/#{branch}" : nil
        end

        def tag_push
          !remote_tag_hash || remote_tag_hash != branch_hash ? tag : nil
        end
      end
    end
  end
end
