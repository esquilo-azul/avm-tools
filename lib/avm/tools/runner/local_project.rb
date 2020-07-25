# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'
require 'avm/local_projects/instance'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        require_sub __FILE__
        include ::EacCli::DefaultRunner

        runner_definition do
          desc 'Utilities for local projects.'
          arg_opt '-C', '--path', 'Path to local project instance.'
          subcommands
        end

        private

        def instance_uncached
          ::Avm::LocalProject::Instance.new(instance_path)
        end

        def instance_path_uncached
          (options.fetch('--path') || '.').to_pathname.expand_path
        end
      end
    end
  end
end
