# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class LocalProject
        class EacAsciidoctorBase0
          require_sub __FILE__

          runner_with :help, :subcommands do
            desc 'EacAsciidoctorBase0 utitilies for local projects.'
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
