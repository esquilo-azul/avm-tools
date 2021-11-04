# frozen_string_literal: true

require 'avm/eac_ubuntu_base0/runners/base'

::RSpec.describe ::Avm::EacUbuntuBase0::Runners::Base do
  include_examples 'in_avm_registry', 'runners'
end
