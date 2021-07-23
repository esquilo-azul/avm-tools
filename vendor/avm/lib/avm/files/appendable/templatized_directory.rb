# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/files/appendable/resource_base'
require 'eac_templates/directory'

module Avm
  module Files
    module Appendable
      class TemplatizedDirectory < ::Avm::Files::Appendable::ResourceBase
        attr_reader :source_path

        def initialize(appender, source_path)
          super(appender)
          @source_path = source_path
        end

        def write_on(target_dir)
          raise 'Variables source not set' if appender.variables_source.blank?

          ::EacTemplates::Directory.new(source_path).apply(
            appender.variables_source,
            target_dir
          )
        end
      end
    end
  end
end
