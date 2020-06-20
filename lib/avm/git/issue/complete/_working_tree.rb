# frozen_string_literal: true

module Avm
  module Git
    module Issue
      class Complete
        def clean_workspace_result
          r = @git.dirty_files.none?
          ::Avm::Result.success_or_error(r, 'yes', 'no')
        end
      end
    end
  end
end
