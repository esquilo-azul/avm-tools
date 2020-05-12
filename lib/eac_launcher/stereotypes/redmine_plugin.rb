# frozen_string_literal: true

require 'eac_launcher/stereotype'

module EacLauncher
  module Stereotypes
    class RedminePlugin
      include EacLauncher::Stereotype

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
