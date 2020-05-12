# frozen_string_literal: true

RSpec.describe ::EacLauncher::Ruby::Gem::Specification do
  let(:gemspec_file) { ::File.join(DUMMY_DIR, 'ruby_gem_stub', 'ruby_gem_stub.gemspec') }
  let(:instance) { ::EacLauncher::Ruby::Gem::Specification.new(gemspec_file) }

  describe '#parse_version_file' do
    it 'should parse valid version file' do
      file = ::File.join(DUMMY_DIR, 'ruby_gem_stub', 'lib', 'ruby_gem_stub', 'version.rb')
      expect(::File.exist?(file)).to eq true
      version = ::EacLauncher::Ruby::Gem::Specification.parse_version_file(file)
      expect(version).to eq('1.0.0.pre.stub')
    end

    it 'should not parse invalid version file' do
      file = __FILE__
      expect(::File.exist?(file)).to eq true
      version = ::EacLauncher::Ruby::Gem::Specification.parse_version_file(file)
      expect(version).to be_nil
    end
  end

  describe '#name' do
    it 'should return gemspec name' do
      expect(instance.name).to eq('ruby_gem_stub')
    end
  end

  describe '#version' do
    it 'should return gemspec version' do
      expect(instance.version).to eq('1.0.0.pre.stub')
    end
  end

  describe '#full_name' do
    it 'should return gem full name' do
      expect(instance.full_name).to eq('ruby_gem_stub-1.0.0.pre.stub')
    end
  end
end
