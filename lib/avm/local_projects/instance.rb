# frozen_string_literal: true

require 'avm/instances/configuration'
require 'eac_launcher/paths/real'
require 'eac_ruby_utils/core_ext'
require 'avm/projects/stereotypes'

module Avm
  module LocalProjects
    class Instance
      enable_simple_cache
      common_constructor :path do
        self.path = path.to_pathname
        source_stereotypes_mixins
      end

      delegate :to_s, to: :path

      # Backward compatibility with [EacLauncher::Paths::Logical].
      # @return [EacLauncher::Paths::Real].
      def real
        ::EacLauncher::Paths::Real.new(path.to_path)
      end

      private

      # @return [Avm::Instances::Configuration]
      def configuration_uncached
        ::Avm::Instances::Configuration.find_in_path(path)
      end

      def stereotypes_uncached
        ::Avm::Projects::Stereotypes.list.select { |s| s.match?(self) }
      end

      def source_stereotypes_mixins
        stereotypes.each do |s|
          s.local_project_mixin_module.if_present { |v| extend(v) }
        end
      end
    end
  end
end
