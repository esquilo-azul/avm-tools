# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Stereotypes
    module EacUbuntuBase0
      class Apache
        common_constructor :host_env

        def etc_root
          '/etc/apache2'
        end

        def service(command)
          host_env.command('sudo', 'service', 'apache2', command)
        end
      end
    end
  end
end
