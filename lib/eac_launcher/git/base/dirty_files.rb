# frozen_string_literal: true

require 'active_support/core_ext/object'

module EacLauncher
  module Git
    class Base < ::EacLauncher::Paths::Real
      module DirtyFiles
        delegate :dirty?, to: :eac_git

        def dirty_files
          eac_git.dirty_files.map do |df|
            ::OpenStruct.new(
              df.to_h.merge(path: df.path.to_path, absolute_path: df.absolute_path.to_path)
            )
          end
        end
      end
    end
  end
end
