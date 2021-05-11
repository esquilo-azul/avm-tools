# frozen_string_literal: true

require 'avm/core_ext'
require 'avm/eac_asciidoctor_base0/build'
require 'avm/eac_asciidoctor_base0/project'

module Avm
  module Tools
    class Runner
      class AppSrc
        class EacAsciidoctorBase0
          class Build
            runner_with :help do
              desc 'Build the project'
              arg_opt '-d', '--target-dir', 'Directory to build'
            end

            def run
              start_banner
              build.run
            end

            private

            def build_uncached
              ::Avm::EacAsciidoctorBase0::Build.new(runner_context.call(:project),
                                                    target_directory: parsed.target_dir)
            end

            def default_target_directory
              runner_context.call(:project).root.join('build')
            end

            def start_banner
              runner_context.call(:project_banner)
              infov 'Target directory', build.target_directory
            end
          end
        end
      end
    end
  end
end
