# frozen_string_literal: true

require 'avm/tools/runner'
require 'tmpdir'

::RSpec.describe ::Avm::Tools::Runner::Git::Deploy, git: true do
  let(:git) { stubbed_git_repository }
  let(:reference) { git.current_branch }
  let(:stub_file1) { 'stub1.txt' }
  let(:stub_content1) { 'CONTENT 111' }
  let(:stub_file2) { 'stub2.txt' }
  let(:stub_content2) { 'CONTENT 222' }
  let(:commit_sha1) do
    git.file(stub_file1).write(stub_content1)
    git.execute!('add', stub_file1)
    git.execute!('commit', '-m', 'First commit.')
    git.rev_parse('HEAD')
  end

  let(:commit_sha2) do
    git.execute!('checkout', commit_sha1)
    git.file(stub_file1).delete
    git.file(stub_file2).write(stub_content2)
    git.execute!('add', stub_file1, stub_file2)
    git.execute!('commit', '-m', 'Second commit.')
    git.rev_parse('HEAD')
  end

  let(:target_stub_file1) { ::File.join(target_dir, stub_file1) }
  let(:target_stub_file2) { ::File.join(target_dir, stub_file2) }

  context 'with local target' do
    let(:target_dir) { ::File.join(::Dir.mktmpdir, 'target') }

    before do
      commit_sha1
      ::Avm::Tools::Runner.new(argv: ['git', '-C', git] + %w[deploy] + [target_dir]).run
    end

    it { expect(::File.read(target_stub_file1)).to eq(stub_content1) }
    it { expect(::File.exist?(target_stub_file2)).to eq(false) }

    context 'with second commit' do
      before do
        commit_sha2
        ::Avm::Tools::Runner.new(argv: ['git', '-C', git] + %w[deploy] + [target_dir]).run
      end

      it { expect(::File.exist?(target_stub_file1)).to eq(false) }
      it { expect(::File.read(target_stub_file2)).to eq(stub_content2) }
    end
  end

  context 'with ssh target', ssh: true do
    let(:env) { ::EacRubyUtils::Rspec::StubbedSsh.default.build_env }
    let(:tmpdir) { env.command('mktemp', '-d').execute! }
    let(:target_dir) { ::File.join(tmpdir, 'target') }
    let(:target_url) { "#{env.uri}#{target_dir}" }

    before do
      commit_sha1
      ::Avm::Tools::Runner.new(argv: ['git', '-C', git] + %w[deploy] + [target_url]).run
    end

    it { expect(env.file(target_stub_file1).read).to eq(stub_content1) }
    it { expect(env.file(target_stub_file2).exist?).to eq(false) }

    context 'with second commit' do
      before do
        commit_sha2
        ::Avm::Tools::Runner.new(argv: ['git', '-C', git] + %w[deploy] + [target_url]).run
      end

      it { expect(env.file(target_stub_file1).exist?).to eq(false) }
      it { expect(env.file(target_stub_file2).read).to eq(stub_content2) }
    end
  end
end
