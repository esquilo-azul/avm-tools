# frozen_string_literal: true

require 'avm/sources/runner'
require 'avm/tools/app_src'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc < ::Avm::Sources::Runner
        require_sub __FILE__

        def instance_banner
          infov 'Instance', instance
          infov 'Stereotypes', instance.stereotypes.map(&:label).join(', ')
        end

        def subject
          source
        end

        private

        def instance_uncached
          ::Avm::Tools::AppSrc.new(source_path)
        end
      end
    end
  end
end
