# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner
      class Git
        class DirtyFiles < ::EacRubyUtils::Console::DocoptRunner
          enable_console_speaker

          FIELDS = {
            i: :index, w: :worktree, p: :path, a: :absolute_path
          }.map { |k, v| ["%#{k}", v] }.to_h

          FIELDS_DOC = FIELDS.map { |k, v| "  #{k} => #{v}" }.join("\n")

          DOC = <<~DOCOPT
            Lists dirty files in Git repository.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help                     Mostra esta ajuda.
              -f --format=<format>          Format of each line (See "Format fields") [default: %p].

            Format fields:
            #{FIELDS_DOC}
          DOCOPT

          def run
            context(:git).dirty_files.each do |file|
              out("#{format_file(file)}\n")
            end
          end

          private

          def format_file(file)
            FIELDS.inject(options.fetch('--format')) { |a, e| a.gsub(e.first, file.send(e.last)) }
          end
        end
      end
    end
  end
end
