# frozen_string_literal: true

require 'eac_launcher/paths/real'
require 'eac_ruby_utils/core_ext'
require 'avm/projects/stereotypes'

module Avm
  module LocalProject
    class Instance
      enable_simple_cache
      common_constructor :path do
        self.path = path.to_pathname
      end

      # Backward compatibility with [EacLauncher::Paths::Logical].
      # @return [EacLauncher::Paths::Real].
      def real
        ::EacLauncher::Paths::Real.new(path.to_path)
      end

      private

      def stereotypes_uncached
        ::Avm::Projects::Stereotypes.list.select { |s| s.match?(self) }
      end
    end
  end
end
