# frozen_string_literal: true

require 'avm/files/formatter'
require 'eac_cli/core_ext'
require 'avm/git/launcher/base'

module Avm
  module Tools
    class Runner
      class Files
        class Format
          runner_with :help do
            desc 'Format files.'
            bool_opt '-a', '--apply', 'Confirm changes.'
            bool_opt '-n', '--no-recursive', 'No recursive.'
            bool_opt '-v', '--verbose', 'Verbose'
            bool_opt '-d', '--git-dirty', 'Select Git dirty files to format.'
            pos_arg :paths, repeat: true, optional: true
          end

          def run
            ::Avm::Files::Formatter.new(source_paths, formatter_options).run
          end

          def formatter_options
            { ::Avm::Files::Formatter::OPTION_APPLY => parsed.apply?,
              ::Avm::Files::Formatter::OPTION_RECURSIVE => !parsed.no_recursive?,
              ::Avm::Files::Formatter::OPTION_VERBOSE => parsed.verbose? }
          end

          def git
            @git ||= ::Avm::Git::Launcher::Base.new('.')
          end

          def git_dirty_files
            git.dirty_files.map { |f| git.root_path.join(f.path) }.select(&:exist?).map(&:to_s)
          end

          def source_paths
            if parsed.git_dirty?
              parsed.paths + git_dirty_files
            else
              parsed.paths.if_present(%w[.])
            end
          end
        end
      end
    end
  end
end
