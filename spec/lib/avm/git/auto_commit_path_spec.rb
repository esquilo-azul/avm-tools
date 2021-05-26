# frozen_string_literal: true

require 'avm/launcher/git/base'
require 'tmpdir'
require 'avm/git/auto_commit_path'

RSpec.describe ::Avm::Git::AutoCommitPath, git: true do
  let(:git) { ::Avm::Launcher::Git::Base.new(stubbed_git_local_repo.root_path.to_path) }

  describe '#class_name' do
    {
      'app/models/mynamespace/the_class.rb' => 'Mynamespace::TheClass',
      'lib/ruby/lib/cliutils/eac_redmine_base0/activity.rb' => 'Cliutils::EacRedmineBase0::Activity'
    }.each do |path, expected_class_name|
      context "when path is \"#{path}\"" do
        let(:instance) { described_class.new(git, "#{git}/#{path}") }

        it { expect(instance.class_name).to eq(expected_class_name) }
      end
    end
  end
end
