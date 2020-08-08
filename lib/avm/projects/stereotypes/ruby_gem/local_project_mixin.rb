# frozen_string_literal: true

require 'avm/patches/eac_ruby_gems_utils/gem'
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
        end
      end
    end
  end
end
