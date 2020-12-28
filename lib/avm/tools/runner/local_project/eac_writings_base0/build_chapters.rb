# frozen_string_literal: true

require 'avm/eac_writings_base0/project_build'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class EacWritingsBase0
          class BuildChapters
            runner_with :help do
              arg_opt '-o', '--output-dir', 'Output chapters to specific directory.'
            end

            def run
              runner_context.call(:project_banner)
              output_dir.mkpath
              project.chapters.each_with_index do |c, i|
                ::Avm::EacWritingsBase0::ProjectBuild.new(project, chapter_build_options(c, i))
              end
            end

            private

            def chapter_build_options(chapter, index)
              output_name = "#{(index + 1).to_s.rjust(3, '0')}_#{chapter}.pdf"
              { output_file: output_dir.join(output_name), chapter: chapter }
            end

            def output_dir_uncached
              (
                parsed.output_dir || project.default_output_dir.join('chapters')
              ).to_pathname
            end

            def project
              runner_context.call(:project)
            end
          end
        end
      end
    end
  end
end
