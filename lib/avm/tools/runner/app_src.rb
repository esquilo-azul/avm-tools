# frozen_string_literal: true

require 'avm/tools/app_src'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        require_sub __FILE__
        runner_with :help, :subcommands do
          desc 'Utilities for local projects.'
          arg_opt '-C', '--path', 'Path to local project instance.'
          subcommands
        end

        def instance_banner
          infov 'Instance', instance
          infov 'Stereotypes', instance.stereotypes.map(&:label).join(', ')
        end

        private

        def instance_uncached
          ::Avm::Tools::AppSrc.new(instance_path)
        end

        def instance_path_uncached
          (parsed.path || '.').to_pathname.expand_path
        end
      end
    end
  end
end
