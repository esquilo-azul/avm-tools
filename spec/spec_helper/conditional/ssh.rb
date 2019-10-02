# frozen_string_literal: true

require 'eac_ruby_utils/rspec/stubbed_ssh'

::EacRubyUtils::Rspec::Conditional.default.add(:ssh) do
  ::EacRubyUtils::Rspec::StubbedSsh.default.validate
end
