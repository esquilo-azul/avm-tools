# frozen_string_literal: true

require 'avm/eac_writings_base0/project'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class EacWritingsBase0 < ::EacRubyUtils::Console::DocoptRunner
          require_sub __FILE__
          runner_with
          enable_simple_cache

          runner_definition do
            desc 'EacWritingsBase0 utitilies for local projects.'
            subcommands
          end

          def project_banner
            infov 'Project', project.name
            infov 'Path', project.root
          end

          private

          def project_uncached
            ::Avm::EacWritingsBase0::Project.new(context(:instance_path))
          end
        end
      end
    end
  end
end
