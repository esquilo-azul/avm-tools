# frozen_string_literal: true

require 'avm/projects/stereotype'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      class Git
        require_sub __FILE__
        include Avm::Projects::Stereotype

        class << self
          def match?(path)
            File.directory?(path.real.subpath('.git'))
          end

          def color
            :white
          end
        end
      end
    end
  end
end
