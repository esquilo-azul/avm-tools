# frozen_string_literal: true

require 'eac_launcher/vendor/github'

RSpec.describe ::EacLauncher::Vendor::Github do
  describe '#to_ssh_url' do
    SSH_URL = 'git@github.com:esquilo-azul/eac_launcher.git'
    NO_SSH_URL = 'https://otherhost.com/esquilo-azul/eac_launcher'

    {
      nil => nil,
      '   ' => nil,
      'https://github.com/esquilo-azul/eac_launcher' => SSH_URL,
      'https://github.com/esquilo-azul/eac_launcher.git' => SSH_URL,
      SSH_URL => SSH_URL,
      NO_SSH_URL => NO_SSH_URL
    }.each do |input, expected|
      it "converts \"#{input}\" to \"#{expected}\"" do
        expect(described_class.to_ssh_url(input)).to eq(expected)
      end
    end
  end
end
