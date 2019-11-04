# frozen_string_literal: true

require 'avm/instances/base'

RSpec.describe ::Avm::Instances::Base do
  before do
    ::Avm.configs_storage_path = ::File.join(__dir__, 'base_spec_configs_storage.yml')
  end

  describe '#read_entry' do
    context 'when a auto value is requested' do
      {}.each do |instance_id, values|
        values.each do |input, expected|
          it "read entry #{instance_id}.#{input} should return \"#{expected}\"" do
            expect(described_class.by_id(instance_id).read_entry(input)).to eq(expected)
          end
        end
      end
    end
  end
end
