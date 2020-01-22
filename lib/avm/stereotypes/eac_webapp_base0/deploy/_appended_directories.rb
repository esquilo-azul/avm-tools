# frozen_string_literal: true

require 'avm/path_string'

module Avm
  module Stereotypes
    module EacWebappBase0
      class Deploy
        APPENDED_DIRECTORIES_ENTRY_KEY = 'deploy.appended_directories'

        def appended_directories
          appended_directories_from_instance_entry + appended_directories_from_options
        end

        def appended_directories_from_instance_entry
          ::Avm::PathString.paths(instance.read_entry_optional(APPENDED_DIRECTORIES_ENTRY_KEY))
        end

        def appended_directories_from_options
          options[:appended_directories] || []
        end
      end
    end
  end
end
