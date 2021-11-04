# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'
require 'avm/files/appendable/resource_base'

module Avm
  module Files
    module Appendable
      class TarOutputCommand < ::Avm::Files::Appendable::ResourceBase
        attr_reader :command

        def initialize(appender, command)
          super(appender)
          @command = command
        end

        def write_on(target_dir)
          command.pipe(
            ::EacRubyUtils::Envs.local.command('tar', '-xf', '-', '-C', target_dir)
          ).execute!
        end
      end
    end
  end
end
