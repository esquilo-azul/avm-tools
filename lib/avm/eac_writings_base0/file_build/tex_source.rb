# frozen_string_literal: true

module Avm
  module EacWritingsBase0
    class FileBuild
      module TexSource
        class << self
          def match?(subpath)
            ::File.extname(subpath) == '.tex'
          end
        end

        private

        def copy(target_path)
          ::File.write(target_path, target_content)
        end

        def target_content
          s = ::File.read(source_path)
          replacements.each do |from, to|
            s = s.gsub(from, to)
          end
          s
        end

        def replacements
          { '%dir%' => ::File.dirname(subpath) }
        end
      end
    end
  end
end
