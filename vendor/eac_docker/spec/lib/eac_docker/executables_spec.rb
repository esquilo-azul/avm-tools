# frozen_string_literal: true

require 'eac_docker/executables'

RSpec.describe(::EacDocker::Executables, docker: true) do
  it 'output version' do
    expect(described_class.docker.command('--version').execute!).to be_present
  end
end
