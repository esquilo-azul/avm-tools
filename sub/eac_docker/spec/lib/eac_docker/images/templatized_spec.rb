# frozen_string_literal: true

require 'eac_docker/images/templatized'
require 'eac_templates/searcher'

RSpec.describe(::EacDocker::Images::Templatized, docker: true) do
  let(:fixtures_dir) { ::Pathname.new('templatized_spec_files').expand_path(__dir__) }
  let(:instance) { StubDockerImage.new }

  before do
    ::EacTemplates::Searcher.default.included_paths << fixtures_dir
    stub_const('StubDockerImage', Class.new(described_class))
  end

  describe '#provide' do
    it { expect { instance.provide }.not_to raise_error }
  end
end
