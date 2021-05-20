# frozen_string_literal: true

require 'avm/eac_writings_base0/project'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
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
