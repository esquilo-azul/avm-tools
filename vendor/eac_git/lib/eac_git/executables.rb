# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'

module EacGit
  module Executables
    class << self
      include ::EacRubyUtils::SimpleCache

      def env
        ::EacRubyUtils::Envs.local
      end

      private

      def git_uncached
        r = env.executable('git', '--version')
        r.extend(GitCommandExtensions)
        r
      end

      def tar_uncached
        env.executable('tar', '--version')
      end

      module GitCommandExtensions
        def command(*args)
          super(*args).envvar('PATH', path_with_git_subrepo)
        end

        def gem_root
          '../..'.to_pathname.expand_path(__dir__)
        end

        def git_subrepo_root
          gem_root.join('vendor', 'git-subrepo')
        end

        def path_with_git_subrepo
          ([git_subrepo_root.join('lib').to_path] +
              ENV['PATH'].if_present('').split(::File::PATH_SEPARATOR))
            .join(::File::PATH_SEPARATOR)
        end
      end
    end
  end
end
