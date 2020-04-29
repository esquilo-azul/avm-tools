# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'eac_launcher/git/error'
require 'eac_ruby_utils/patch'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Patches
    module EacLauncherGitBase
      extend ::ActiveSupport::Concern

      included do
        extend ClassMethods
        include InstanceMethods
      end

      module ClassMethods
        # @return [EacLauncher::Git::Base]
        def by_root(search_base_path)
          new(find_root(search_base_path).to_path)
        end

        # Searches the root path for the Git repository which includes +search_base_path+.
        # @return [Pathname]
        def find_root(search_base_path)
          path = search_base_path.to_pathname.expand_path
          loop do
            return path if path.join('.git').exist?
            raise "\".git\" not found for \"#{search_base_path}\"" if path.parent.root?

            path = path.parent
          end
        end
      end

      module InstanceMethods
        def execute(*args)
          args, options = build_args(args)
          ::EacRubyUtils::Envs.local.command(*args).execute(options)
        end

        def command(*args)
          args, _options = build_args(args)
          ::EacRubyUtils::Envs.local.command(*args)
        end

        def dirty?
          dirty_files.any?
        end

        def dirty_files
          execute!('status', '--porcelain', '--untracked-files').each_line.map do |line|
            parse_status_line(line.gsub(/\n\z/, ''))
          end
        end

        # @return [Pathname]
        def root_path
          @root_path ||= self.class.find_root(to_s)
        end

        private

        def parse_status_line(line)
          m = /\A(.)(.)\s(.+)\z/.match(line)
          ::Kernel.raise "Status pattern does not match \"#{line}\"" unless m
          ::OpenStruct.new(index: m[1], worktree: m[2], path: m[3],
                           absolute_path: ::File.expand_path(m[3], self))
        end
      end
    end
  end
end

::EacRubyUtils.patch(::EacLauncher::Git::Base, ::Avm::Patches::EacLauncherGitBase)
