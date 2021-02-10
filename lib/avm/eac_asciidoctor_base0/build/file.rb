# frozen_string_literal: true

require 'avm/executables'

module Avm
  module EacAsciidoctorBase0
    class Build
      class File
        enable_console_speaker
        common_constructor :build, :subpath

        def run
          infov 'Building', subpath
          target_path.parent.mkpath
          ::Avm::Executables.asciidoc.command('--out-file', target_path, source_path).system!
        end

        def source_path
          build.project.root.join(subpath)
        end

        def target_path
          build.target_directory.join(subpath).basename_sub('.*') { |b| "#{b}.html" }
        end
      end
    end
  end
end
