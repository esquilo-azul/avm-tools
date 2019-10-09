# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'avm/git/file_auto_fixup'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class AutoFixup < ::EacRubyUtils::Console::DocoptRunner
          DOC = <<~DOCOPT
            Auto fixup files.

              Usage:
              __PROGRAM__ [options] [<files>...]
            __PROGRAM__ -h | --help

            Options:
              -h --help                     Mostra esta ajuda.
          DOCOPT

          def run
            files.each do |file|
              ::Avm::Git::FileAutoFixup.new(context(:git), file).run
            end
          end

          private

          def files
            files_from_option || dirty_files
          end

          def files_from_option
            r = options.fetch('<files>')
            r.any? ? r : nil
          end

          def dirty_files
            context(:git).dirty_files.map(&:path)
          end
        end
      end
    end
  end
end
