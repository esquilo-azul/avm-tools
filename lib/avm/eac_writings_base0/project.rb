# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWritingsBase0
    class Project
      common_constructor :root do
        self.root = root.to_pathname
      end

      def chapters
        chapters_file.read.split("\n").map(&:strip).reject { |c| c == '' }
      end

      def chapters_file
        root.join('chapters')
      end

      def name
        root.basename.to_s
      end

      def default_output_dir
        root.join('dist')
      end

      def default_output_file
        root.join("#{name}.pdf")
      end
    end
  end
end
