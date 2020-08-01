# frozen_string_literal: true

require 'avm/launcher/instances/base'

RSpec.describe ::Avm::Launcher::Instances::Base do
  describe '#options' do
    context 'when instance is "eac_launcher_stub"' do
      let(:instance) { ::EacLauncher::Context.current.instance('/eac_launcher_stub') }

      it { expect(instance).to be_a(described_class) }
      it { expect(instance.options.git_current_revision).to eq('origin/master') }
      it { expect(instance.options.git_publish_remote).to eq('publish') }
      it { expect(instance.options.publishable?).to eq(true) }
    end

    context 'when instance is "ruby_gem_stub"' do
      let(:instance) { ::EacLauncher::Context.current.instance('/ruby_gem_stub') }

      it { expect(instance.options.git_current_revision).to eq('git_current_revision_setted') }
      it { expect(instance.options.git_publish_remote).to eq('git_publish_remote_setted') }
      it { expect(instance.options.publishable?).to eq(false) }
    end
  end
end
