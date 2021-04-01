# frozen_string_literal: true

require 'eac_ruby_utils/rspec/conditional'
require 'eac_git/executables'

module EacGit
  module Rspec
    require_sub __FILE__

    class << self
      def configure
        ::EacRubyUtils::Rspec::Conditional.default.add(:git) do
          ::EacGit::Executables.git.validate
        end
        RSpec.configure do |config|
          ::EacRubyUtils::Rspec::Conditional.default.configure(config)
          config.include ::EacGit::Rspec::StubbedGitLocalRepo
        end
      end
    end
  end
end
