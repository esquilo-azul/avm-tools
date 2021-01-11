# frozen_string_literal: true

require 'avm/git/auto_commit_path'
require 'avm/files/formatter'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Git
        class AutoCommit
          runner_with :help do
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
            runner_context.call(:git).system!('reset', 'HEAD')
          end

          def dirty_paths
            return [] unless parsed.dirty?

            runner_context.call(:git).dirty_files.map do |d|
              runner_context.call(:git).root_path.join / d.path
            end
          end

          def format_files
            return unless parsed.format?

            infom 'Formating files...'
            ::Avm::Files::Formatter.new(paths.map(&:path),
                                        ::Avm::Files::Formatter::OPTION_APPLY => true).run
          end

          def paths_uncached
            (parsed.paths.map { |p| p.to_pathname.expand_path } + dirty_paths)
              .reject(&:directory?).sort.uniq
              .map { |path| ::Avm::Git::AutoCommitPath.new(runner_context.call(:git), path) }
          end

          def run_paths
            paths.each(&:run)
          end
        end
      end
    end
  end
end
