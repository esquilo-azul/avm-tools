# frozen_string_literal: true

require 'avm/projects/stereotype'

module EacLauncher
  module Stereotypes
    class RedminePlugin
      include Avm::Projects::Stereotype

      class << self
        def match?(path)
          File.exist?(path.real.subpath('init.rb'))
        end

        def color
          :light_magenta
        end
      end
    end
  end
end
