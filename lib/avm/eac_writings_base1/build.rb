# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/clearable_directory'

module Avm
  module EacWritingsBase1
    class Build
      require_sub __FILE__
      enable_console_speaker
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :target_directory
      common_constructor :project, :options, default: [{}] do
        self.options = self.class.lists.option.hash_keys_validate!(options.symbolize_keys)
      end

      def run
        infov 'Files to build', source_files.count
        target_directory.clear
        source_files.each(&:run)
      end

      def default_target_directory
        project.root.join('build')
      end

      def target_directory
        ::EacRubyUtils::Fs::ClearableDirectory.new(
          options[OPTION_TARGET_DIRECTORY] || default_target_directory
        )
      end

      def source_files_uncached
        r = []
        project.root.children.each do |child|
          next unless child.extname == '.asc'

          r << ::Avm::EacWritingsBase1::Build::File.new(self, child.basename)
        end
        r
      end
    end
  end
end