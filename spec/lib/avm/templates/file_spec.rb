# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/templates/file'

RSpec.describe ::Avm::Templates::File do
  let(:files_dir) { ::File.join(__dir__, 'file_spec_files') }
  let(:source_path) { ::File.join(files_dir, 'source.template') }
  let(:instance) { described_class.new(source_path) }
  let(:expected_content) { ::File.read(::File.join(files_dir, 'expected_content')) }

  describe '#apply' do
    context 'when config is a hash' do
      let(:config) { { name: 'Fulano de Tal', age: 33 } }

      it { expect(instance.apply(config)).to eq(expected_content) }
    end

    context 'when config responds to read_entry' do
      let(:config) { ::Avm::Instances::Base.by_id('myapp_dev') }

      before do
        ENV['MYAPP_DEV_NAME'] = 'Fulano de Tal'
        ENV['MYAPP_DEV_AGE'] = '33'
      end

      it { expect(instance.apply(config)).to eq(expected_content) }
    end
  end

  describe '#variables' do
    it { expect(instance.variables).to eq(::Set.new(%w[name age])) }
  end
end
