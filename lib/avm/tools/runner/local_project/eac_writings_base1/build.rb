# frozen_string_literal: true

require 'avm/eac_writings_base1/build'
require 'avm/eac_writings_base1/project'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class LocalProject
        class EacWritingsBase1
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
              ::Avm::EacWritingsBase1::Build.new(runner_context.call(:project),
                                                 target_directory: parsed.target_dir)
            end

            def default_target_directory
              runner_context.call(:project).root.join('build')
            end

            def start_banner
              runner_context.call(:project_banner)
              infov 'Target directory', build.target_directory
            end
            #
            #            def target_directory_uncached
            #              .if_present(default_target_directory).to_pathname
            #            end
          end
        end
      end
    end
  end
end
