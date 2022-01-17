# frozen_string_literal: true

require 'avm/eac_rails_base0/apache_path'
require 'avm/eac_rails_base0/instance'

RSpec.describe ::Avm::EacRailsBase0::ApachePath do
  describe '#no_ssl_site_content' do
    let(:instance) { ::Avm::EacRailsBase0::Instance.by_id('stub-app_0') }
    let(:apache_path) { described_class.new(instance) }
    let(:fixtures_dir) { ::Pathname.new('apache_path_spec_files').expand_path(__dir__) }
    let(:expect_file) { fixtures_dir.join('stub-app_0_apache_path.conf') }
    let(:expected_content) { expect_file.read }

    before do
      instance.entry(::Avm::Instances::EntryKeys::FS_PATH).write('/path/to/stub-app_0')
      instance.entry('web.url').write('http://stubapp.net/stub-app_0')
    end

    it do
      expect(apache_path.content).to eq(expected_content)
    end
  end
end
