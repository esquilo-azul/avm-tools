# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Build
        class File
          enable_console_speaker
          common_constructor :build, :subpath

          def run
            infov 'Building', subpath
            ::Asciidoctor.convert_file source_path.to_path,
                                       to_file: target_path.to_path, safe: :unsafe, mkdirs: true
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
end
