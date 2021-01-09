# frozen_string_literal: true

require 'avm/git/auto_commit_path'
require 'avm/files/formatter'
require 'eac_cli/default_runner'

module Avm
  module Tools
    class Runner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class AutoCommit < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Commit with message based in content commited.'
            bool_opt '-d', '--dirty', 'Select dirty files.'
            bool_opt '-f', '--format', 'Format files before commit.'
            pos_arg 'paths', repeat: true, optional: true
          end

          def run
            clear_stage
            banner
            format_files
            run_paths
          end

          private

          def banner
            infov 'Paths', paths.count
          end

          def clear_stage
            infom 'Clearing stage...'
            context(:git).system!('reset', 'HEAD')
          end

          def dirty_paths
            return [] unless options.fetch('--dirty')

            context(:git).dirty_files.map { |d| context(:git).root_path.join / d.path }
          end

          def format_files
            return unless options.fetch('--format')

            infom 'Formating files...'
            ::Avm::Files::Formatter.new(paths.map(&:path),
                                        ::Avm::Files::Formatter::OPTION_APPLY => true).run
          end

          def paths_uncached
            (options.fetch('<paths>')
              .map { |p| p.to_pathname.expand_path } + dirty_paths)
              .reject(&:directory?)
              .sort.uniq.map { |path| ::Avm::Git::AutoCommitPath.new(context(:git), path) }
          end

          def run_paths
            paths.each(&:run)
          end
        end
      end
    end
  end
end
