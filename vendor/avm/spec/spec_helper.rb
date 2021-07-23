# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  require 'eac_ruby_gem_support/rspec'
  ::EacRubyGemSupport::Rspec.setup(::File.expand_path('..', __dir__))
end

require 'eac_git/rspec'
::EacGit::Rspec.configure
