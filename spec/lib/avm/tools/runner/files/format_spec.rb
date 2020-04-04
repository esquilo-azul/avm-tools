# frozen_string_literal: true

require 'avm/tools/runner'
require 'aranha/parsers/source_target_fixtures'
require 'tmpdir'
require 'fileutils'

::RSpec.describe ::Avm::Tools::Runner::Files::Format do
  let(:source_stf) do
    ::Aranha::Parsers::SourceTargetFixtures.new(
      ::File.join(__dir__, 'format_spec_files')
    )
  end

  before do
    source_files = copy_to_target_dir(source_stf.source_files) { |b| b.gsub(/\.source\Z/, '') }
    ::Avm::Tools::Runner.new(argv: ['files', 'format', '--apply',
                                    source_target_fixtures.fixtures_directory]).run
    copy_to_target_dir(source_stf.target_files)
    source_files.each { |source_file| ::FileUtils.mv(source_file, source_file + '.source') }
  end

  include_examples 'source_target_fixtures', __FILE__

  def fixtures_dir
    @fixtures_dir ||= ::Dir.mktmpdir
  end

  def source_data(source_file)
    ::File.read(source_file)
  end

  def target_data(target_file)
    ::File.read(target_file)
  end

  private

  def copy_to_target_dir(files, &block)
    files.map do |file|
      target_basename = ::File.basename(file)
      target_basename = block.call(target_basename) if block
      target_path = ::File.join(source_target_fixtures.fixtures_directory, target_basename)
      ::FileUtils.cp(file, target_path)
      target_path
    end
  end
end
