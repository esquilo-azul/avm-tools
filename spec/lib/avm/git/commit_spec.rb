# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'tmpdir'
require 'avm/git/commit'

RSpec.describe ::Avm::Git::Commit do
  let(:git) do
    r = ::EacLauncher::Git::Base.new(::Dir.mktmpdir)
    r.init
    r
  end

  let(:first_commit_sha1) do
    ::File.write(::File.join(git, 'a.txt'), 'AAA')
    ::File.write(::File.join(git, 'b.txt'), 'BBB')
    git.execute!('add', '.')
    git.execute!('commit', '-m', 'First commit.')
    git.rev_parse('HEAD')
  end

  let(:second_commit_sha1) do
    first_commit_sha1
    ::File.write(::File.join(git, 'a.txt'), 'AAAAA')
    ::File.unlink(::File.join(git, 'b.txt'))
    ::File.write(::File.join(git, 'c.txt'), 'CCC')
    git.execute!('add', '.')
    git.execute!('commit', '-m', 'Second commit.')
    git.rev_parse('HEAD')
  end

  let(:first_commit) { described_class.new(git, first_commit_sha1) }
  let(:second_commit) { described_class.new(git, second_commit_sha1) }

  describe '#files' do
    it { expect(first_commit.files.count).to eq(2) }
    it { expect(second_commit.files.count).to eq(3) }
  end

  describe '#files_size' do
    it { expect(first_commit.files_size).to eq(6) }
    it { expect(second_commit.files_size).to eq(8) }
  end

  describe '#root_child?' do
    it { expect(first_commit.root_child?).to eq(true) }
    it { expect(second_commit.root_child?).to eq(false) }
  end
end
