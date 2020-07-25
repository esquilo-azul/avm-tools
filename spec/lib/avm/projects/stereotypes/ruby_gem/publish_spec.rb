# frozen_string_literal: true

require 'avm/projects/stereotypes'
require 'eac_launcher/context'

RSpec.describe ::Avm::Projects::Stereotypes::RubyGem::Publish do
  describe '#publish' do
    let(:instance) { ::EacLauncher::Context.current.instance('/ruby_gem_stub') }

    it 'dries run publish for Ruby Gems' do
      allow_any_instance_of(described_class).to receive(:gem_versions_uncached).and_return([])
      expect(instance).to be_a ::EacLauncher::Instances::Base
      ::EacLauncher::Context.current.publish_options = {
        confirm: false, new: true, stereotype: 'RubyGem'
      }
      ::Avm::Projects::Stereotypes::RubyGem::Publish.new(instance).run
    end
  end
end
