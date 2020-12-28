# frozen_string_literal: true

require 'avm/eac_writings_base0/project'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class EacWritingsBase0
          require_sub __FILE__
          enable_simple_cache

          runner_with :help, :subcommands do
            desc 'EacWritingsBase0 utitilies for local projects.'
            subcommands
          end

          def project_banner
            infov 'Project', project.name
            infov 'Path', project.root
          end

          private

          def project_uncached
            ::Avm::EacWritingsBase0::Project.new(runner_context.call(:instance_path))
          end
        end
      end
    end
  end
end
