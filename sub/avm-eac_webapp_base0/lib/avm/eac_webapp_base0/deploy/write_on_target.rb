# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    class Deploy
      module WriteOnTarget
        def write_on_target
          ::Avm::Files::Deploy.new(
            instance.host_env,
            instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
          ).append_plain_directory(build_dir).run
        end
      end
    end
  end
end
