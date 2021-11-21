# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'

::RSpec.describe ::Avm::EacWebappBase0::Sources::Base do
  include_examples 'in_avm_registry', 'sources'
end
