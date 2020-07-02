# frozen_string_literal: true

require 'eac_ruby_utils/rspec/conditional'
require 'eac_git/executables'

module EacGit
  module Rspec
    class << self
      def configure
        ::EacRubyUtils::Rspec::Conditional.default.add(:git) do
          ::EacGit::Executables.git.validate
        end
        RSpec.configure { |config| ::EacRubyUtils::Rspec::Conditional.default.configure(config) }
      end
    end
  end
end
