# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/sources/build'
require 'eac_ruby_base0/core_ext'
require 'os'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Runner
        class Build
          runner_with :help do
            desc 'Build the project'
            arg_opt '-d', '--target-dir', 'Directory to build'
            bool_opt '--open', 'Show the result.'
          end

          def run
            start_banner
            build.run
            open
          end

          private

          def build_uncached
            ::Avm::EacAsciidoctorBase0::Sources::Build.new(runner_context.call(:project),
                                                           target_directory: parsed.target_dir)
          end

          def default_target_directory
            runner_context.call(:project).root.join('build')
          end

          def open
            return unless parsed.open?

            infom "Opening \"#{open_path}\"..."
            ::EacRubyUtils::Envs.local.command(OS.open_file_command, open_path).system!
          end

          def open_path
            build.source_files.first.target_path
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
