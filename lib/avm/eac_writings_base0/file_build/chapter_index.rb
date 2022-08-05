# frozen_string_literal: true

module Avm
  module EacWritingsBase0
    class FileBuild
      module ChapterIndex
        class << self
          def match?(subpath)
            ::File.basename(subpath) == 'index.tex'
          end
        end

        private

        def target_subpath
          ::Avm::EacLatexBase0::Sources::Build.chapter_filename(
            File.basename(File.dirname(subpath))
          ) + '.tex'
        end
      end
    end
  end
end
