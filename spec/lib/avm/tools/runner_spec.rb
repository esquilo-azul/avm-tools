# frozen_string_literal: true

RSpec.describe Avm::Tools::Runner do
  let(:argv) { %w[--version] }
  let(:instance) { described_class.create(argv: argv) }

  it 'runs' do
    expect { instance.run }.to(
      output("#{Avm::Tools::VERSION}\n").to_stdout_from_any_process
    )
  end
end
