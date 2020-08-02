# frozen_string_literal: true

require 'eac_launcher/instances/base'

RSpec.describe ::EacLauncher::Instances::Base do
  describe '#options' do
    it 'default options' do
      i = ::EacLauncher::Context.current.instance('/eac_launcher_stub')
      expect(i).to be_instance_of(described_class)
      expect(i.options.git_current_revision).to eq('origin/master')
      expect(i.options.git_publish_remote).to eq('publish')
      expect(i.options.publishable?).to eq(true)
    end

    it 'options setted' do
      i = ::EacLauncher::Context.current.instance('/ruby_gem_stub')
      expect(i.options.git_current_revision).to eq('git_current_revision_setted')
      expect(i.options.git_publish_remote).to eq('git_publish_remote_setted')
      expect(i.options.publishable?).to eq(false)
    end
  end
end
