# frozen_string_literal: true

require 'eac_ruby_utils/struct'

RSpec.describe ::EacRubyUtils::Struct do
  let(:instance) { described_class.new(a: 1, b: '') }

  describe '#[]' do
    it { expect(instance[:a]).to eq(1) }
    it { expect(instance['a']).to eq(1) }
    it { expect(instance[:a?]).to eq(true) }
    it { expect(instance['a?']).to eq(true) }
    it { expect(instance[:b]).to eq('') }
    it { expect(instance['b']).to eq('') }
    it { expect(instance[:b?]).to eq(false) }
    it { expect(instance['b?']).to eq(false) }
    it { expect(instance[:c]).to eq(nil) }
    it { expect(instance['c']).to eq(nil) }
    it { expect(instance[:c?]).to eq(false) }
    it { expect(instance['c?']).to eq(false) }
  end

  describe '#fetch' do
    it { expect(instance.fetch(:a)).to eq(1) }
    it { expect(instance.fetch('a')).to eq(1) }
    it { expect(instance.fetch(:a?)).to eq(true) }
    it { expect(instance.fetch('a?')).to eq(true) }
    it { expect(instance.fetch(:b)).to eq('') }
    it { expect(instance.fetch('b')).to eq('') }
    it { expect(instance.fetch(:b?)).to eq(false) }
    it { expect(instance.fetch('b?')).to eq(false) }
    it { expect { instance.fetch(:c) }.to raise_error(::KeyError) }
    it { expect { instance.fetch('c') }.to raise_error(::KeyError) }
    it { expect { instance.fetch(:c?) }.to raise_error(::KeyError) }
    it { expect { instance.fetch('c?') }.to raise_error(::KeyError) }
  end

  describe '#property_method' do
    it { expect(instance.a).to eq(1) }
    it { expect(instance.a?).to eq(true) }
    it { expect(instance.b).to eq('') }
    it { expect(instance.b?).to eq(false) }
    it { expect { instance.c }.to raise_error(::NoMethodError) }
    it { expect { instance.c? }.to raise_error(::NoMethodError) }
  end
end
