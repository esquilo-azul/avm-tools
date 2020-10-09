# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'tmpdir'
require 'avm/git/auto_commit_path'

RSpec.describe ::Avm::Git::AutoCommitPath, git: true do
  let(:git) { stubbed_git_repository }

  describe '#class_name' do
    {
      'app/models/mynamespace/the_class.rb' => 'Mynamespace::TheClass',
      'lib/ruby/lib/cliutils/eac_redmine_base0/activity.rb' =>
        'Ruby::Lib::Cliutils::EacRedmineBase0::Activity'
    }.each do |path, expected_class_name|
      context "when path is \"#{path}\"" do
        let(:instance) { described_class.new(git, "#{git}/#{path}") }

        it { expect(instance.class_name).to eq(expected_class_name) }
      end
    end
  end
end
