# frozen_string_literal: true

require 'avm/instances/application'

RSpec.describe ::Avm::Instances::Application do
  let(:instance) { described_class.new('avm-tools') }

  before do
    ENV['AVMTOOLS_EXIST'] = 'exist'
    ENV.delete('AVMTOOLS_NOT_EXIST')
  end

  describe '#id' do
    it { expect(instance.id).to eq('avm-tools') }
  end

  describe '#path_prefix' do
    it { expect(instance.path_prefix).to eq(['avm-tools']) }
  end

  describe '#read_entry' do
    it { expect(instance.read_entry(:exist)).to eq('exist') }
  end
end
