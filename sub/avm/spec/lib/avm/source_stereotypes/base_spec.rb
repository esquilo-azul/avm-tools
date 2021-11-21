# frozen_string_literal: true

require 'avm/source_stereotypes/base'

::RSpec.describe ::Avm::SourceStereotypes::Base do
  include_examples 'in_avm_registry', :source_stereotypes
end
