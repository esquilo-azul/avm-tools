# frozen_string_literal: true

require 'eac_git/executables'

RSpec.describe(::EacGit::Executables, git: true) do
  it 'output version' do
    expect(described_class.git.command('--version').execute!).to be_present
  end

  it 'subrepo output version' do
    expect(described_class.git.command('subrepo', '--version').execute!).to be_present
  end
end
