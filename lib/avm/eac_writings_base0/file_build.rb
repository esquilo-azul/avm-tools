# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWritingsBase0
    class FileBuild
      require_sub __FILE__
      include ::Avm::EacWritingsBase0::FileBuild::BaseStereotype
      DEFAULT_STEREOTYPES = [::Avm::EacWritingsBase0::FileBuild::ChapterIndex,
                             ::Avm::EacWritingsBase0::FileBuild::TexSource].freeze

      class << self
        def stereotypes
          DEFAULT_STEREOTYPES
        end
      end

      common_constructor :project, :subpath do
        self.class.stereotypes.each do |stereotype|
          singleton_class.prepend(stereotype) if stereotype.match?(subpath)
        end
      end

      def build_to_dir(build_root_target_dir)
        create_target_dir(build_root_target_dir)
        copy(target_path(build_root_target_dir))
      end

      private

      def create_target_dir(build_root_target_dir)
        FileUtils.mkdir_p(File.dirname(target_path(build_root_target_dir)))
      end

      def source_path
        File.join(project.root, subpath)
      end

      def target_path(build_root_target_dir)
        File.join(build_root_target_dir, target_subpath)
      end
    end
  end
end
