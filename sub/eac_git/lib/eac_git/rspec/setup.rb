# frozen_string_literal: true

require 'eac_git/executables'
require 'eac_git/rspec/stubbed_git_local_repo'

module EacGit
  module Rspec
    module Setup
      def self.extended(setup_obj)
        setup_obj.setup_conditional_git
        setup_obj.setup_stubbed_git_local_repo
      end

      def setup_conditional_git
        conditional(:git) { ::EacGit::Executables.git.validate }
      end

      def setup_stubbed_git_local_repo
        rspec_config.include ::EacGit::Rspec::StubbedGitLocalRepo
      end
    end
  end
end
