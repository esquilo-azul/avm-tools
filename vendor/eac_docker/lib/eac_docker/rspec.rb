# frozen_string_literal: true

require 'eac_ruby_utils/rspec/conditional'
require 'eac_docker/executables'

module EacDocker
  module Rspec
    class << self
      def configure
        ::EacRubyUtils::Rspec::Conditional.default.add(:docker) do
          ::EacDocker::Executables.docker.validate
        end
        RSpec.configure { |config| ::EacRubyUtils::Rspec::Conditional.default.configure(config) }
      end
    end
  end
end
