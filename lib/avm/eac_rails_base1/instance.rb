# frozen_string_literal: true

require 'avm/eac_webapp_base0/instance'
require 'eac_ruby_gems_utils/gem'

module Avm
  module EacRailsBase1
    class Instance < ::Avm::EacWebappBase0::Instance
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
