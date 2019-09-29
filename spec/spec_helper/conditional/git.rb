# frozen_string_literal: true

require 'avm/executables'

::EacRubyUtils::Rspec::Conditional.default.add(:git) do
  ::Avm::Executables.git.validate
end
