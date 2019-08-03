# frozen_string_literal: true

require 'avm/tools/runner'
require 'tmpdir'
require 'fileutils'

::RSpec.describe ::Avm::Tools::Runner::Files::Rotate do
  let(:workdir) { ::Dir.mktmpdir }
  let(:source_basename) { 'myfile.tar.gz' }
  let(:source_path) { ::File.join(workdir, source_basename) }

  before do
    ::FileUtils.touch(source_path)
  end

  it { expect(::File.exist?(source_path)).to eq(true) }

  context 'when run' do
    let(:files_with_prefix) { ::Dir["#{workdir}/myfile_*.tar.gz"] }

    before do
      ::Avm::Tools::Runner.new(argv: ['files', 'rotate', source_path]).run
    end

    it { expect(::File.exist?(source_path)).to eq(false) }
    it { expect(files_with_prefix.count).to eq(1) }
  end
end
