# frozen_string_literal: true

require 'avm/runners/base'
require 'avm/eac_ubuntu_base0/instances/base'
require 'eac_ruby_utils/patches/module/require_sub'

module Avm
  module EacUbuntuBase0
    module Runners
      class Base < ::Avm::Runners::Base
        enable_simple_cache
        require_sub __FILE__

        INSTANCE_ID = 'eac-ubuntu-base0_self'

        runner_with :help, :subcommands do
          subcommands
        end

        private

        def instance_uncached
          ::Avm::EacUbuntuBase0::Instances::Base.by_id(INSTANCE_ID)
        end
      end
    end
  end
end
