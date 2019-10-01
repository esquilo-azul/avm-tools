# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_launcher/git/base'
require 'fileutils'
require 'tmpdir'

module Avm
  module Git
    module SpecHelper
      def stubbed_git_repository(bare = false)
        path = ::Dir.mktmpdir
        ::EacRubyUtils::Envs.local.command(stubbed_git_repository_args(path, bare)).execute!
        StubbedGitRepository.new(path)
      end

      private

      def stubbed_git_repository_args(path, bare)
        r = %w[git init]
        r << '--bare' if bare
        r + [path]
      end

      class StubbedGitRepository < ::EacLauncher::Git::Base
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
          ::File.join(git, *subpath)
        end

        def touch
          ::FileUtils.touch(path)
        end

        def delete
          ::File.unlink(path)
        end

        def write(content)
          ::File.write(path, content)
        end
      end
    end
  end
end
