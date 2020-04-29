# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'eac_launcher/git/error'
require 'eac_ruby_utils/patch'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Patches
    module EacLauncherGitBase
      extends ::ActiveSupport::Concern

      included do
        include InstanceMethods
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

        def root_path
          r = ::Pathname.new(to_s).expand_path
          loop do
            return r if r.join('.git').exist?
            raise "\".git\" not found for \"#{self}\"" if r.dirname.root?

            r = r.dirname
          end
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
