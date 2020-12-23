# frozen_string_literal: true

require 'avm/eac_webapp_base0/deploy'
require 'avm/eac_writings_base1/project'
require 'avm/eac_writings_base1/build'

module Avm
  module EacWritingsBase1
    class Deploy < ::Avm::EacWebappBase0::Deploy
      def build_content
        ::Avm::EacWritingsBase1::Build.new(
          project,
          ::Avm::EacWritingsBase1::Build::OPTION_TARGET_DIRECTORY => build_dir
        ).run
      end

      private

      def project_uncached
        ::Avm::EacWritingsBase1::Project.new(
          instance.source_instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
        )
      end
    end
  end
end
