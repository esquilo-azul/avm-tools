# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

RSpec.describe Avm::Tools::Runner::Source::Issue::Complete, :git do
  let(:remote_name) { 'origin' }
  let(:issue_ref) { 'issue_123' }
  let(:remote_repos) { stubbed_git_local_repo(true) }
  let(:local_repos) { stubbed_git_local_repo }
  let(:eac_local_repos) { Avm::Git::Launcher::Base.new(local_repos.root_path.to_path) }

  context 'when branch is pushed' do
    before do
      eac_local_repos.assert_remote_url(remote_name, remote_repos.root_path.to_path)
      local_repos.command('checkout', '-b', issue_ref).execute!
      local_repos.file('myfile1.txt').touch
      local_repos.file(Avm::Sources::Base::Configuration::CONFIGURATION_FILENAMES.first).touch
      local_repos.command('add', '.').execute!
      local_repos.command('commit', '-m', 'myfile1.txt').execute!
      local_repos.command('push', 'origin', issue_ref).execute!
    end

    it 'remote repos has a issue branch' do
      expect(eac_local_repos.remote_hashs(remote_name)).to include("refs/heads/#{issue_ref}")
    end

    it 'remote repos does not have a issue tag' do
      expect(eac_local_repos.remote_hashs(remote_name)).not_to include("refs/tags/#{issue_ref}")
    end

    context 'when "git issue complete" is called' do
      before do
        Avm::Tools::Runner.run(argv: ['source', '-C', eac_local_repos] +
            %w[issue complete --yes])
      end

      it 'remote repos does not have a issue branch' do
        expect(eac_local_repos.remote_hashs(remote_name)).not_to include("refs/heads/#{issue_ref}")
      end

      it 'remote repos has a issue tag' do
        expect(eac_local_repos.remote_hashs(remote_name)).to include("refs/tags/#{issue_ref}")
      end
    end
  end
end
