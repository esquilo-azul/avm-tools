# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_docker/container'

module EacDocker
  module Images
    class Base
      def container
        ::EacDocker::Container.new(self)
      end
    end
  end
end
