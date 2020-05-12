# frozen_string_literal: true

require 'eac_launcher/stereotype'

module EacLauncher
  module Stereotypes
    class Rails
      include EacLauncher::Stereotype

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
