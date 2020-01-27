# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/instances/entry_keys'

RSpec.describe ::Avm::Instances::Base do
  let(:app2) { described_class.by_id('app_2') }
  let(:app1) { described_class.by_id('app_1') }
  let(:app0) { described_class.by_id('app_0') }

  before do
    ::Avm.configs_storage_path = ::File.join(__dir__, 'base_spec_configs_storage.yml')
  end

  describe '#read_entry' do
    context 'when a auto value is requested' do
      {
        'app_0' => {
          fs_path: '/fs_root/app_0',
          data_fs_path: '/data_fs_root/app_0',
          ::Avm::Instances::EntryKeys::DATABASE_NAME => 'app_0',
          ::Avm::Instances::EntryKeys::DATABASE_USERNAME => 'user1',
          ::Avm::Instances::EntryKeys::DATABASE_PASSWORD => 'pass1',
          ::Avm::Instances::EntryKeys::DATABASE_HOSTNAME => 'database.net',
          ::Avm::Instances::EntryKeys::DATABASE_PORT => 5432,
          'ssh.hostname' => 'myhost.com',
          'ssh.username' => 'myuser',
          'ssh.url' => 'ssh://otheruser@otherhost.com'
        },
        'app_2' => {
          ::Avm::Instances::EntryKeys::DATABASE_HOSTNAME => '127.0.0.1',
          'source_instance_id' => 'app_dev'
        },
        'app_3' => {
          ::Avm::Instances::EntryKeys::DATABASE_SYSTEM => 'postgresql',
          ::Avm::Instances::EntryKeys::DATABASE_NAME => 'app_1_db',
          ::Avm::Instances::EntryKeys::DATABASE_USERNAME => 'user1',
          ::Avm::Instances::EntryKeys::DATABASE_PASSWORD => 'pass1',
          ::Avm::Instances::EntryKeys::DATABASE_HOSTNAME => 'database.net',
          ::Avm::Instances::EntryKeys::DATABASE_PORT => 5432
        }
      }.each do |instance_id, values|
        values.each do |input, expected|
          it "read entry #{instance_id}.#{input} should return \"#{expected}\"" do
            expect(described_class.by_id(instance_id).read_entry(input)).to eq(expected)
          end
        end
      end
    end
  end

  describe '#by_id' do
    {
      'avm-tools_0' => %w[avm-tools 0],
      'avm-tools_dev' => %w[avm-tools dev],
      'redmine1-abc2_dev3' => %w[redmine1-abc2 dev3]
    }.each do |id, expected|
      context "when input ID is \"#{id}\"" do
        let(:instance) { described_class.by_id(id) }

        it "returns application.id=#{expected.first}" do
          expect(instance.application.id).to eq(expected.first)
        end

        it "returns instance.suffix=#{expected.last}" do
          expect(instance.suffix).to eq(expected.last)
        end
      end
    end
  end
end
