# frozen_string_literal: true

require 'avm/eac_webapp_base0/deploy'
require 'avm/eac_asciidoctor_base0/sources/base'
require 'avm/eac_asciidoctor_base0/sources/build'

module Avm
  module EacAsciidoctorBase0
    class Deploy < ::Avm::EacWebappBase0::Deploy
      def build_content
        ::Avm::EacAsciidoctorBase0::Sources::Build.new(
          project,
          ::Avm::EacAsciidoctorBase0::Sources::Build::OPTION_TARGET_DIRECTORY => build_dir
        ).run
      end

      private

      def project_uncached
        ::Avm::EacAsciidoctorBase0::Sources::Base.new(
          instance.source_instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
        )
      end
    end
  end
end
