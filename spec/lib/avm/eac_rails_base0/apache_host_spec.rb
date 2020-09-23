# frozen_string_literal: true

require 'avm/eac_rails_base0/apache_host'
require 'avm/eac_rails_base0/instance'

RSpec.describe ::Avm::EacRailsBase0::ApacheHost do
  describe '#no_ssl_site_content' do
    let(:instance) { ::Avm::EacRailsBase0::Instance.by_id('stub-app_0') }
    let(:apache_host) { described_class.new(instance) }
    let(:expected_content) do
      ::File.read(::File.join(__dir__, 'apache_host_spec_no_ssl_content.conf'))
    end

    before do
      ENV['STUBAPP_0_FS_PATH'] = '/path/to/stub-app_0'
      ENV['STUBAPP_0_WEB_URL'] = 'http://stubapp.net'
    end

    it do
      expect(apache_host.no_ssl_site_content).to eq(expected_content)
    end
  end
end
