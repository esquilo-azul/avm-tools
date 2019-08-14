# frozen_string_literal: true

require 'rubocop'

RSpec.describe ::RuboCop, slow: true do
  let(:root_path) { ::File.dirname(__dir__) }
  let(:runner) { ::RuboCop::Runner.new({}, RuboCop::ConfigStore.new) }

  it 'rubocop return ok' do
    expect(runner.run([root_path])).to eq(true)
  end
end
