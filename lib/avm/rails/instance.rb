# frozen_string_literal: true

module Avm
  module Rails
    module Instance
      def bundle(*args)
        the_gem.bundle(*args).chdir_root.envvar('RAILS_ENV', 'production')
      end

      def rake(*args)
        bundle('exec', 'rake', *args)
      end

      def the_gem
        @the_gem ||= ::EacRubyGemsUtils::Gem.new(::File.join(read_entry('fs_path')), host_env)
      end
    end
  end
end
