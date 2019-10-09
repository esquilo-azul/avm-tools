# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'eac_launcher/git/error'
require 'eac_ruby_utils/patch'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Patches
    module EacLauncherGitBase
      def execute(*args)
        args, options = build_args(args)
        ::EacRubyUtils::Envs.local.command(*args).execute(options)
      end

      def command(*args)
        args, _options = build_args(args)
        ::EacRubyUtils::Envs.local.command(*args)
      end
    end
  end
end

::EacRubyUtils.patch(::EacLauncher::Git::Base, ::Avm::Patches::EacLauncherGitBase)
