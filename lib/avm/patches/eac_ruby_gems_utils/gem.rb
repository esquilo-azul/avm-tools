# frozen_string_literal: true

require 'avm/sources/configuration'
require 'eac_ruby_gems_utils/gem'
require 'eac_ruby_utils/core_ext'

module Avm
  module Patches
    module EacRubyGemsUtils
      module Gem
        enable_simple_cache

        private

        def configuration_uncached
          ::Avm::Sources::Configuration.find_in_path(root)
        end

        def gemfile_path_uncached
          return super unless configuration.present? && configuration.rubocop_gemfile.present?

          configuration.rubocop_gemfile
        end
      end
    end
  end
end

::EacRubyGemsUtils::Gem.prepend(::Avm::Patches::EacRubyGemsUtils::Gem)
