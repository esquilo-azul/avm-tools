# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'git'
require 'eac_launcher/paths/real'

module EacLauncher
  module Git
    class Base < ::EacLauncher::Paths::Real
      module Underlying
        def execute!(*args)
          args, options = build_args(args)
          ::EacRubyUtils::Envs.local.command(*args).execute!(options)
        end

        def system!(*args)
          args, options = build_args(args)
          ::EacRubyUtils::Envs.local.command(*args).system!(options)
        end

        def init
          git
          self
        end

        private

        def build_args(args)
          options = {}
          if args.last.is_a?(Hash)
            options = args.last
            args.pop
          end
          args = args.first if args.first.is_a?(Array)
          [['git', '-C', self, '--no-pager'] + args, options]
        end

        def git_uncached
          FileUtils.mkdir_p(self)
          if File.exist?(subpath('.git'))
            ::Git.open(self)
          else
            ::Git.init(self)
          end
        end
      end
    end
  end
end
