# frozen_string_literal: true

module Avm
  module EacWritingsBase0
    class ProjectBuild
      class << self
        def chapter_filename(chapter_name)
          "chapter_#{chapter_name}"
        end
      end

      module ChaptersContent
        private

        def chapter
          options[:chapter]
        end

        def chapter_filename(chapter_name)
          ::Avm::EacWritingsBase0::ProjectBuild.chapter_filename(chapter_name)
        end

        def check_chapter
          return unless chapter
          return if project.chapters.include?(chapter)

          fatal_error("Chapter not found: \"#{chapter}\" (List: #{project.chapters})")
        end

        def include_content
          main_path = source_temp_dir.join('main.tex')
          main_path.write(main_path.read.gsub(CONTENT_VAR, include_chapters_content))
        end

        def include_chapters_content
          r = chapters_content
          r = "\\maketitle\n\n#{r}" if chapter.blank?
          r
        end

        def chapters_content
          project.chapters.map { |c| "\\include{#{chapter_filename(c)}}" }.join("\n")
        end
      end
    end
  end
end
