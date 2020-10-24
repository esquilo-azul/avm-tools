# frozen_string_literal: true

require 'avm/executables'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/temp'
require 'eac_ruby_utils/fs/clearable_directory'

module Avm
  module EacWritingsBase0
    class ProjectBuild
      require_sub __FILE__, include_modules: true
      enable_console_speaker

      CONTENT_VAR = '%%%CONTENT%%%'

      common_constructor :project, :options do
        run
      end

      private

      attr_reader :source_temp_dir

      def run
        start_banner
        check_chapter
        build
        success('Done!')
      end

      def start_banner
        infov('Chapter', chapter)
        infov('Output file', output_file)
      end

      def build
        on_temp_source_dir do
          copy_project_files
          copy_commons_files
          include_content
          compile
          check
          move_output_to_target
          open_output
        end
      end

      def check
        return if ::File.size(temp_output_file).positive?

        fatal_error("Zero-size file builded: #{temp_output_file}")
      end

      def compile
        compile_command.execute!.each_line do |line|
          if line.include?('No file')
            raise 'Command returned without error, but there is at least one "No file" line in' \
              "log: #{line}"
          end
        end
      end

      def compile_command
        ::Avm::Executables.latex.command(*compile_command_args).chdir(source_temp_dir)
      end

      def compile_command_args
        r = ["-output-director=#{build_dir}", '-output-format=pdf',
             '-interaction=nonstopmode', '-halt-on-error', '-file-line-error']
        r << if chapter.present?
               "\\includeonly{#{chapter_filename(chapter)}}\\input{main.tex}"
             else
               './main.tex'
             end
        r
      end

      def move_output_to_target
        File.rename(temp_output_file, output_file)
        infov('Size', ::Filesize.from("#{File.size(output_file)} B").pretty)
      end

      def temp_output_file
        File.join(build_dir, 'main.pdf')
      end

      def on_temp_source_dir
        if options[:source_dir].present?
          @source_temp_dir = ::EacRubyUtils::Fs::ClearableDirectory.new(options.source_dir).clear
          yield
        else
          ::EacRubyUtils::Fs::Temp.on_directory do |directory|
            @source_temp_dir = directory
            yield
          end
        end
      end

      def build_dir
        r = project.root.join('build')
        r.mkpath
        r
      end

      def output_file
        (options[:output_file] || project.default_output_file)
      end

      def open_output
        return unless options[:open]

        infom("Opening \"#{output_file}\"")
        ::Avm::Executables.xdg_open.command(output_file).system!
      end
    end
  end
end
