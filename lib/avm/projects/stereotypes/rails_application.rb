# frozen_string_literal: true

require 'avm/projects/stereotype'

module Avm
  module Projects
    module Stereotypes
      class RailsApplication
        include Avm::Projects::Stereotype

        class << self
          def match?(path)
            File.exist?(path.real.subpath('config.ru')) && path.real.basename != 'dummy'
          end

          def color
            :magenta
          end
        end
      end
    end
  end
end
