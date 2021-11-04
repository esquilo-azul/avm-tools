# frozen_string_literal: true

require 'eac_ruby_gems_utils/gem'

::RSpec.describe ::EacRubyGemsUtils::Gem::VersionFile do
  let(:stubs_dir) { ::Pathname.new(__dir__).join('version_file_spec_files') }
  let(:stub_file) { stubs_dir.join('a_version_file.rb') }
  let(:instance) { described_class.new(stub_file) }
  let(:target_version) { ::Gem::Version.new('0.69.1') }

  describe '#value' do
    it { expect(instance.value).to eq(target_version) }
  end
end
