# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'avm/tools/runner'
require 'tmpdir'
require 'fileutils'

::RSpec.describe ::Avm::Tools::Runner::Git::Issue::Complete, git: true do
  let(:remote_name) { 'origin' }
  let(:issue_ref) { 'issue_123' }
  let(:remote_repos) do
    path = '/tmp/remote_repos'
    ::FileUtils.rm_rf(path)
    ::FileUtils.mkdir_p(::File.dirname(path))
    ::EacRubyUtils::Envs.local.command('git', 'init', '--bare', path).system!
    ::EacLauncher::Git::Base.new(path)
  end

  let(:local_repos) do
    ::FileUtils.rm_rf('/tmp/local_repos')
    ::EacLauncher::Git::Base.new('/tmp/local_repos')
  end

  context 'when branch is pushed' do
    before do
      local_repos.assert_remote_url(remote_name, remote_repos)
      local_repos.execute!('checkout', '-b', issue_ref)
      ::FileUtils.touch(::File.join(local_repos, 'myfile1.txt'))
      local_repos.execute!('add', '.')
      local_repos.execute!('commit', '-m', 'myfile1.txt')
      local_repos.execute!('push', 'origin', issue_ref)
    end

    it 'remote repos has a issue branch' do
      expect(local_repos.remote_hashs(remote_name)).to include("refs/heads/#{issue_ref}")
    end

    it 'remote repos does not have a issue tag' do
      expect(local_repos.remote_hashs(remote_name)).not_to include("refs/tags/#{issue_ref}")
    end

    context 'when "git issue complete" is called' do
      before do
        ::Avm::Tools::Runner.new(argv: ['git', '-C', local_repos] + %w[issue complete --yes]).run
      end

      it 'remote repos does not have a issue branch' do
        expect(local_repos.remote_hashs(remote_name)).not_to include("refs/heads/#{issue_ref}")
      end

      it 'remote repos has a issue tag' do
        expect(local_repos.remote_hashs(remote_name)).to include("refs/tags/#{issue_ref}")
      end
    end
  end
end
