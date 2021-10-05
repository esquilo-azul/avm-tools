# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/files/appendable/resource_base'

module Avm
  module Files
    module Appendable
      class PlainDirectory < ::Avm::Files::Appendable::ResourceBase
        attr_reader :source_path

        def initialize(appender, source_path)
          super(appender)
          @source_path = source_path.to_pathname
        end

        def write_on(target_dir)
          raise "\"#{source_path}\" is not a directory" unless source_path.directory?

          ::FileUtils.cp_r("#{source_path}/.", target_dir.to_path)
        end
      end
    end
  end
end
