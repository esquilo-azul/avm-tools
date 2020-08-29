# frozen_string_literal: true

require 'avm/patches/eac_ruby_gems_utils/gem'
require 'avm/version'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      class RubyGem
        module LocalProjectMixin
          # @return [EacRubyGemsUtils::Gem]
          def ruby_gem
            @ruby_gem ||= ::EacRubyGemsUtils::Gem.new(path)
          end

          def version
            ruby_gem.version.if_present { |v| ::Avm::Version.new(v) }
          end

          def version=(value)
            ruby_gem.version_file.value = value
          end
        end
      end
    end
  end
end
