# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/require_sub'
require 'eac_launcher/git/base'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Tools
    class Runner
      class Git
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Git utilities for AVM.'
          arg_opt '-C', '--path', 'Path to Git repository.'
          subcommands
        end

        def repository_path
          repository_path? ? parsed.path : '.'
        end

        def repository_path?
          parsed.path.present?
        end

        def git
          @git ||= ::EacLauncher::Git::Base.by_root(repository_path)
        end
      end
    end
  end
end
