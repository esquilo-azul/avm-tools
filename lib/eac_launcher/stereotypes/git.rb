# frozen_string_literal: true

require 'avm/projects/stereotype'

module EacLauncher
  module Stereotypes
    class Git
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
