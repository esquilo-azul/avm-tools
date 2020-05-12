# frozen_string_literal: true

require 'eac_launcher/git/base'

RSpec.describe ::EacLauncher::Git::Base do
  context 'new non-bare repository' do
    let(:repo) do
      r = described_class.new(::Dir.mktmpdir)
      r.git
      r
    end

    describe '#remote_exist?' do
      it { expect(repo.remote_exist?('origin')).to eq(false) }

      context 'after remote added' do
        before { repo.execute!('remote', 'add', 'origin', 'file:///path/to/remote') }

        it { expect(repo.remote_exist?('origin')).to eq(true) }

        context 'after remote removed' do
          before { repo.execute!('remote', 'remove', 'origin') }

          it { expect(repo.remote_exist?('origin')).to eq(false) }
        end
      end
    end

    describe '#assert_remote_url' do
      it { expect(repo.remote_exist?('origin')).to eq(false) }

      context 'after asserted remote URL "/remote1"' do
        before { repo.assert_remote_url('origin', '/remote1') }

        it { expect(repo.git.remote('origin').url).to eq('/remote1') }

        context 'after asserted remote URL "/remote2"' do
          before { repo.assert_remote_url('origin', '/remote2') }

          it { expect(repo.git.remote('origin').url).to eq('/remote2') }
        end
      end
    end
  end
end
