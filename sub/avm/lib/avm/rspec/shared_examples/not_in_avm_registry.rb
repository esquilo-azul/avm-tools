# frozen_string_literal: true

require 'avm/registry'

::RSpec.shared_examples 'not_in_avm_registry' do |registry_method = nil|
  registry_method.if_present(::Avm::Registry.registries) { |v| [::Avm::Registry.send(v)] }
    .each do |registry|
    context "when registry is #{registry}" do
      it 'is not in the avm registry' do
        expect(registry.registered_modules).not_to include(described_class)
      end
    end
  end
end
