# frozen_string_literal: true

module Avm
  module Stereotypes
    module Rails
      module Instance
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
