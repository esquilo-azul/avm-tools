# frozen_string_literal: true

require 'avm/tools/runner'
require 'eac_ruby_gems_utils/gem'

::RSpec.describe ::Avm::Tools::Runner::Ruby::Rubocop do
  let(:fixtures_root) { ::Pathname.new(__dir__).expand_path.join('rubocop_spec_files') }
  let(:dir1) { fixtures_root.join('dir1') }
  let(:dir2) { fixtures_root.join('dir2') }
  let(:dir3) { dir1.join('dir3') }
  let(:dir4) { fixtures_root.join('dir4') }

  {
    dir1: '0.48.1',
    dir2: ::EacRubyGemsUtils::Gem.new(APP_ROOT).gemfile_lock_gem_version('rubocop').to_s,
    dir3: '0.48.1',
    dir4: '33.33.33'
  }.each do |dir_name, rubocop_version|
    it "return #{rubocop_version} as Rubocop version for directory #{dir_name}" do
      argv = ['--quiet', 'ruby', 'rubocop', '-C', send(dir_name).to_s, '--', '--version']
      expect { ::Avm::Tools::Runner.new(argv: argv).run }.to(
        output("#{rubocop_version}\n").to_stdout_from_any_process
      )
    end
  end
end
