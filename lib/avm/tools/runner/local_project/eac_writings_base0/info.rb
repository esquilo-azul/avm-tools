# frozen_string_literal: true

require 'avm/eac_writings_base0/project_build'
require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class EacWritingsBase0 < ::EacRubyUtils::Console::DocoptRunner
          class Info
            runner_with
            runner_definition do
              desc 'Information about a loca EacRailsBase0 local project.'
            end

            def run
              runner_context.call(:project_banner)
              infov 'Chapters', project.chapters.count
              project.chapters.each_with_index do |chapter, index|
                infov "  * #{index + 1}", chapter
              end
            end

            private

            def project
              runner_context.call(:project)
            end
          end
        end
      end
    end
  end
end
