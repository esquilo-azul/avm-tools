# frozen_string_literal: true

require 'eac_git/executables'
require 'eac_ruby_utils/core_ext'

module EacGit
  # A Git remote repository referenced by URI.
  class Remote
    require_sub __FILE__

    common_constructor :uri

    def ls
      ::EacGit::Remote::LsResult.by_ls_remote_command_output(
        ::EacGit::Executables.git.command('ls-remote', uri).execute!
      )
    end
  end
end
