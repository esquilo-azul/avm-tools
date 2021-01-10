# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'avm/git/file_auto_fixup'

module Avm
  module Tools
    class Runner
      class Git
        class AutoFixup
          runner_with :help do
            desc 'Auto fixup files.'
            bool_opt '-u', '--unique', 'Automatically select the first commit if it is unique.'
            pos_arg :files, repeat: true, optional: true
          end

          def run
            files.each do |file|
              ::Avm::Git::FileAutoFixup.new(runner_context.call(:git), file, file_options).run
            end
          end

          private

          def file_options
            { Avm::Git::FileAutoFixup::OPTION_UNIQUE => parsed.unique? }
          end

          def files
            files_from_option || dirty_files
          end

          def files_from_option
            r = parsed.files
            r.any? ? r.map { |p| p.to_pathname.expand_path } : nil
          end

          def dirty_files
            runner_context.call(:git).dirty_files.map(&:path)
          end
        end
      end
    end
  end
end
