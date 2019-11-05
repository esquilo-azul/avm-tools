# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/instance'

module Avm
  module Stereotypes
    module EacRailsBase0
      class Instance < ::Avm::Stereotypes::EacWebappBase0::Instance
        FILES_UNITS = { uploads: 'public/uploads' }.freeze

        def bundle(*args)
          host_env.command('bundle', *args)
                  .envvar('BUNDLE_GEMFILE', ::File.join(read_entry('fs_path'), 'Gemfile'))
                  .envvar('RAILS_ENV', 'production')
                  .chdir(read_entry('fs_path'))
        end

        def rake(*args)
          bundle('exec', 'rake', *args)
        end
      end
    end
  end
end
