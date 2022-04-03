# frozen_string_literal: true

require 'avm/instances/application'
require 'avm/instances/base'

module Avm
  module Sources
    class Base
      module Instance
        DEFAULT_INSTANCE_SUFFIX = 'dev'

        def instance_suffix
          DEFAULT_INSTANCE_SUFFIX
        end

        private

        def application_uncached
          ::Avm::Instances::Application.new(path.basename)
        end

        def instance_uncached
          ::Avm::Instances::Base.new(application, DEFAULT_INSTANCE_SUFFIX)
        end
      end
    end
  end
end
