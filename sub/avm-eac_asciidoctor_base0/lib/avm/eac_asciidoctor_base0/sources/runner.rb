# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/base'
require 'eac_ruby_base0/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Runner
        require_sub __FILE__

        runner_with :help, :subcommands do
          desc 'EacAsciidoctorBase0 utitilies for local projects.'
          subcommands
        end

        def project_banner
          infov 'Project', project.application.name
          infov 'Path', project.path
        end

        private

        def project_uncached
          ::Avm::EacAsciidoctorBase0::Sources::Base.new(runner_context.call(:instance_path))
        end
      end
    end
  end
end
