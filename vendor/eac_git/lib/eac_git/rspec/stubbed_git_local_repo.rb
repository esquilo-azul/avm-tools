# frozen_string_literal: true

require 'eac_git/local'
require 'eac_ruby_utils/envs'
require 'fileutils'
require 'tmpdir'

module EacGit
  module Rspec
    module StubbedGitLocalRepo
      def stubbed_git_local_repo(bare = false)
        path = ::Dir.mktmpdir
        ::EacRubyUtils::Envs.local.command(stubbed_git_local_repo_args(path, bare)).execute!
        repo = StubbedGitRepository.new(path)
        repo.command('config', 'user.email', 'theuser@example.net').execute!
        repo.command('config', 'user.name', 'The User').execute!
        repo
      end

      private

      def stubbed_git_local_repo_args(path, bare)
        r = %w[git init]
        r << '--bare' if bare
        r + [path]
      end

      class StubbedGitRepository < ::EacGit::Local
        def file(*subpath)
          StubbedGitRepositoryFile.new(self, subpath)
        end
      end

      class StubbedGitRepositoryFile
        attr_reader :git, :subpath

        def initialize(git, subpath)
          @git = git
          @subpath = subpath
        end

        def path
          git.root_path.join(*subpath)
        end

        def touch
          ::FileUtils.touch(path.to_path)
        end

        def delete
          path.unlink
        end

        def write(content)
          path.write(content)
        end
      end
    end
  end
end
