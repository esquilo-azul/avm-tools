# frozen_string_literal: true

require 'avm/eac_wordpress_base0/apache_host'
require 'avm/eac_wordpress_base0/instance'

RSpec.describe ::Avm::EacWordpressBase0::ApacheHost do
  describe '#no_ssl_site_content' do
    let(:instance) { ::Avm::EacWordpressBase0::Instance.by_id('stub-app_0') }
    let(:apache_host) { described_class.new(instance) }
    let(:expected_content) do
      ::File.read(::File.join(__dir__, 'apache_host_spec_no_ssl_content.conf'))
    end

    before do
      instance.entry('fs_path').write('/path/to/stub-app_0')
      instance.entry('web.url').write('http://stubapp.net')
      instance.entry('system.username').write('myuser')
    end

    it do
      expect(apache_host.no_ssl_site_content).to eq(expected_content)
    end
  end
end
