# frozen_string_literal: true

module Avm
  module EacWritingsBase0
    class FileBuild
      module BaseStereotype
        private

        def target_subpath
          subpath
        end

        def copy(target_path)
          FileUtils.copy_file(source_path, target_path)
        end
      end
    end
  end
end
