# frozen_string_literal: true

require 'eac_launcher/stereotype'

module EacLauncher
  module Stereotypes
    class Git
      include EacLauncher::Stereotype

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
