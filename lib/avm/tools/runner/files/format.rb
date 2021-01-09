# frozen_string_literal: true

require 'avm/files/formatter'
require 'eac_launcher/git/base'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class Files < ::EacRubyUtils::Console::DocoptRunner
        class Format < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Format files.

            Usage:
              __PROGRAM__ [options] [<paths>...]
              __PROGRAM__ -h | --help

            Options:
              -h --help                 Show this screen.
              -a --apply                Confirm changes.
              -n --no-recursive         No recursive.
              -v --verbose              Verbose
              -d --git-dirty            Select Git dirty files to format.
          DOCOPT

          def run
            ::Avm::Files::Formatter.new(source_paths, formatter_options).run
          end

          def formatter_options
            { ::Avm::Files::Formatter::OPTION_APPLY => options.fetch('--apply'),
              ::Avm::Files::Formatter::OPTION_RECURSIVE => !options.fetch('--no-recursive'),
              ::Avm::Files::Formatter::OPTION_VERBOSE => options.fetch('--verbose') }
          end

          def git
            @git ||= ::EacLauncher::Git::Base.new('.')
          end

          def git_dirty_files
            git.dirty_files.map { |f| git.root_path.join(f.path) }.select(&:exist?).map(&:to_s)
          end

          def source_paths
            if options.fetch('--git-dirty')
              options.fetch('<paths>') + git_dirty_files
            else
              options.fetch('<paths>').if_present(%w[.])
            end
          end
        end
      end
    end
  end
end
