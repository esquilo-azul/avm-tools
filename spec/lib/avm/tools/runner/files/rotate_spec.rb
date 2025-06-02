# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

class StubClock
  attr_reader :current

  def initialize(year, month, day)
    @current = ::Time.new(year, month, day)
  end

  def tick
    @current += 1.day
    @current
  end
end

RSpec.describe Avm::Tools::Runner::Files::Rotate do
  let(:workdir) { Dir.mktmpdir }
  let(:source_basename) { 'myfile.tar.gz' }
  let(:source_path) { File.join(workdir, source_basename) }

  before do
    FileUtils.touch(source_path)
  end

  it { expect(File.exist?(source_path)).to be(true) }

  context 'when run' do
    let(:files_with_prefix) { Dir["#{workdir}/myfile_*.tar.gz"] }

    before do
      Avm::Tools::Runner.run(argv: ['files', 'rotate', source_path])
    end

    it { expect(File.exist?(source_path)).to be(false) }
    it { expect(files_with_prefix.count).to eq(1) }
  end

  describe 'space limit' do
    let(:tempdir) { Dir.mktmpdir }
    let(:clock) { StubClock.new(2000, 1, 1) }

    it 'limit space used by rotated files' do # rubocop:disable RSpec/NoExpectationExample
      file1 = create_and_rotate_stub_file([], [])
      file2 = create_and_rotate_stub_file([file1], [])
      file3 = create_and_rotate_stub_file([file2], [file1])
      create_and_rotate_stub_file([file3], [file1, file2])
    end

    def create_and_rotate_stub_file(expect_exist, expect_not_exist)
      rotate_runner = described_class.create(argv: [create_stub_file, '--space-limit=32'])
      rotate_runner.run
      test_files(rotate_runner.rotate, expect_exist, expect_not_exist)
      rotate_runner.rotate.target_path
    end

    def test_files(rotate, expect_exist, expect_not_exist)
      (expect_exist + [rotate.target_path]).each { |path| expect(File).to exist(path) }
      expect_not_exist.each { |path| expect(File).not_to exist(path) }
    end

    def create_stub_file
      stub_path = File.join(tempdir, 'stub.ext')
      File.write(stub_path, 'A' * 16)
      FileUtils.touch(stub_path, mtime: clock.tick)
      stub_path
    end
  end
end
