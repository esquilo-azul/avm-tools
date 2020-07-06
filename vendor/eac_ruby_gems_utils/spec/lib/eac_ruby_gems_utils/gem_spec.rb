# frozen_string_literal: true

require 'eac_ruby_gems_utils/gem'

::RSpec.describe ::EacRubyGemsUtils::Gem do
  let(:mygem_path) { ::Pathname.new(__dir__).expand_path.parent.parent.join('support', 'mygem') }
  let(:mygem) { described_class.new(mygem_path) }

  describe '#bundle' do
    specify do
      expect(mygem.bundle('exec', 'myrunner').execute!).to include('My Runner')
    end
  end

  describe '#rake' do
    specify do
      expect(mygem.rake('mygem:stub').execute!).to include('Stub!')
    end
  end
end
